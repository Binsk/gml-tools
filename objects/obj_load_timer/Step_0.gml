task_start_time = current_time;
while (not ds_queue_empty(task_queue) and current_time - task_start_time < max_frametime){
    var time = current_time;
    var data = ds_queue_head(task_queue);
    task_is_completed = true; // Assume true unles set otherwise
    var return_value = callv(data.task, data.argv);
    if (task_is_completed){ // If the task wasn't suspended; mark it off
        ds_queue_dequeue(task_queue);
        signaler.signal("task-complete", data.title, return_value);
    }
    else
        data.first_run = false;
    
    // If the estimated cost of the next task is more than our frame time; cancel
    // early:
    var time_delta = current_time - time;
    if (current_time + time_delta - task_start_time >= max_frametime)
        break;
}

if (task_count > 0 and ds_queue_empty(task_queue)){
    signaler.signal("tasks-complete", task_count);
    task_count = 0;
}