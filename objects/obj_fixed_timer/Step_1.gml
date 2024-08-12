repeat_count = floor((current_time - last_tick) / tick_delta);

repeat (repeat_count)
	signaler.signal("tick_begin");