
#region PROPERTIES
max_frametime = 10;
task_id = 0; // Simply used to distinguish task names for the demo
#endregion

#region METHODS
/// An example task that might take a very long time to process. Sums all primes
/// from 1 to the specified range.
/// Sum prime script uncerimoniously taken from:
/// https://www.geeksforgeeks.org/sum-of-all-the-prime-numbers-in-a-given-range/
function sum_primes(range){
    function check_prime(value){
        if (value == 1)
            return false;
        
        for (var i = 2; i * i <= value; ++i){
            if (value % i == 0)
                return false;
        }
        
        return true;
    }
    
    // Initialize our script's values
    var cache = {
    	index : 1,	// Current number processing
    	sum : 0		// Current sum of primes from 1 to "index"
    }
    
    // If this is not our first time through the script, start where we left off:
    if (not obj_load_timer.get_is_first_run())
    	cache = obj_load_timer.fetch_task_cache();
    
    for (; cache.index <= range; ++cache.index){
        // Check if we are taking too much time and, if so, store our state and
        // exit until next frame
        if (obj_load_timer.get_should_suspend()){
            obj_load_timer.store_task_cache(cache, cache.index / range);
			return; // We can quit since we've stored our data
        }
        
        if (check_prime(cache.index))
        	cache.sum += cache.index;
    }
    
	return cache.sum; // Return the final result
}
#endregion

#region INIT
loader = instance_create_depth(0, 0, 0, obj_load_timer);
loader.set_max_frametime(max_frametime); // Limit processing task to 10ms a frame
// Show a message when each task is completed giving us the task name and result:
loader.signaler.add_signal("task-complete", method(id, function(title, returnval){
	show_message(string_ext("Finished task [{0}] and the value was [{1}]!", [title, returnval]));
}));
// Simply reset our local task counter for displaying task number
loader.signaler.add_signal("tasks-complete", method(id, function(){
	task_id = 0;
}))
#endregion