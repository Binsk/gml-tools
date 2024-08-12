if (keyboard_check_pressed(ord("1")))
	game_set_speed(20, gamespeed_fps);
else if (keyboard_check_pressed(ord("2")))
	game_set_speed(60, gamespeed_fps);
else if (keyboard_check_pressed(ord("3")))
	game_set_speed(9999, gamespeed_fps);