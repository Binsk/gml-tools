var range = 1000000; // How high to calculate
loader.queue_task(method(id, sum_primes), [range], string_ext("(Task {1}) Sum primes [1..{0}]", [range, ++task_id]));