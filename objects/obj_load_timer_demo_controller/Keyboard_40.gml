max_frametime = max(max_frametime - 0.1, 1);
if (floor(max_frametime) == max_frametime)
	loader.set_max_frametime(max_frametime);