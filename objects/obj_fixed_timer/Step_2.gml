repeat (repeat_count)
	signaler.signal("tick_end");

last_tick += tick_delta * repeat_count;
repeat_count = 0;