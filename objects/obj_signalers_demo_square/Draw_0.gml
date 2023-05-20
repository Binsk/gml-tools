if (is_moving)
	x = xstart + dsin(direction++) * 32;

draw_rectangle(x - 24, y - 24, x + 24, y + 24, false);