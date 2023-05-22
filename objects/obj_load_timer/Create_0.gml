/// @dependencies   Signaler
/// ABOUT
/// The load timer helps simplify distributing intensive processing tasks across
/// multiple frames. Execution will always perform at least 1 task per frame to
/// prevent lockup in the case of severe lag unrelated to the load timer.

#region SIGNALS
/// "tasks-complete" (task_count)             -   thrown when all tasks have completed
/// "task-complete" (title, return) -   thrown when a single task is completed
#endregion

#region PROPERTIES
signaler = new Signaler();
max_frametime = 50; // Number of ms allotted to the load timer per frame
task_queue = ds_queue_create();
task_count = 0; // Used to calculate percentage completed
task_completion_state = undefined;
task_start_time = current_time;
task_is_completed = true;
#endregion

#region METHODS
/// @desc   Queue a new task onto the queue for processing.
/// @param  {method}    method      the method to execute as the task
/// @param  {array}     args=[]     an array of arguments to pass into 
/// @param  {string}    title=""    optional title to distinguish what is being processed
function queue_task(func, argv=[], title=""){
    ds_queue_enqueue(task_queue, {
        task : func, 
        argv : argv,
        title : title,
        cache : undefined,
        first_run : true
    });
    
    ++task_count;
}

/// @desc   Returns the title of the currently active task or undefined if no
///         task is being processed.
function get_active_task(){
    if (ds_queue_empty(task_queue))
        return undefined;
    
    return ds_queue_head(task_queue).title;
}

/// @desc   Returns the overall task count; pending, completed, processing.
function get_task_count(){
    return task_count;
}

/// @desc   Returns the completion rate of our task list between [0..1]
function get_percentage_complete(){
    if (task_count <= 0 or ds_queue_empty(task_queue))
        return 1.0;
    
    var data = ds_queue_head(task_queue);
    
    var pc = 0;
    if (is_struct(data.cache))
        pc = clamp(real(data.cache.percent), 0, 1);
    
    return 1.0 - (ds_queue_size(task_queue) - pc) / task_count;
}

/// @desc   Returns if the current task needs to quit to stay within valid timing
///         thresholds.
function get_should_suspend(){
    return (current_time - task_start_time >= max_frametime);
}

/// @desc   Returns if this is the 'first run' of the current task.
function get_is_first_run(){
    if (ds_queue_empty(task_queue))
        return undefined;
    
    return ds_queue_head(task_queue).first_run;
}

function get_max_frametime(){
    return max_frametime;
}

/// @desc   Sets the maximum number of ms the system can use up per frame for
///         processing. The system will do its best to follow the limit.
function set_max_frametime(frametime=50){
    max_frametime = clamp(real(frametime), 1, infinity);
}

/// @desc   Stores an arbitrary struct of data to pass on to the next frame.
///         If this function is called before the 'return' call of a processing
///         task then the task will NOT be removed; assuming it will need
///         processing on the next frame.
/// @param  {any}    cache=undefined    data to store for the next frame
/// @param  {real}   percent=0.0        percent completion of task (used in get_percentage_complete() but optional)
function store_task_cache(cache=undefined, percentage=0.0){
    if (ds_queue_empty(task_queue))
        return;
    
    var data = ds_queue_head(task_queue);
    data.cache = {
        cache : cache,
        percent : percentage
    };
    task_is_completed = false;
}

/// @desc   Fetches the stored cache of the task from the previous frame. If clear
///         is set to true then the cache will be wiped from storage so that the
///         system will recognize the task as 'complete' at the end of the script.
function fetch_task_cache(clear=true){
    if (ds_queue_empty(task_queue))
        return undefined;
    
    var data = ds_queue_head(task_queue);
    var cache = data.cache.cache;
    if (clear)
        data.cache = undefined;
        
    return cache;
}

/// @desc   Clears the entire task queue, cancelling any pending tasks.
///         If signal_complete is set it will still signal that the tasks were
///         completed.
function clear_task_queue(signal_complete=true){
    ds_queue_clear(task_queue);
    if (not signal_complete)
        task_count = 0;
}
#endregion

#region INIT
#endregion