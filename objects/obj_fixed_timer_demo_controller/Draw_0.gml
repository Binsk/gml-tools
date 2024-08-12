draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(24, 24, "FPS: " + string(fps) + " / " + string(game_get_speed(gamespeed_fps)) + "\nUse the arrow keys to move around\nPress 1, 2, 3 to change FPS cap");