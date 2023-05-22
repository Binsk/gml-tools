draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_circle_color(x, y, 48, player_color, player_color, false);
draw_text_color(x, y, string(player_number), c_white, c_white, c_white, c_white, 1.0);

// Draw status:
draw_rectangle_color(room_width - 24, 24 + 32 * player_number, room_width - 280, 24 + 32 * player_number + 24, player_color, player_color, player_color, player_color, false);

var desc = obj_controller_manager.get_player_controller_description(player_number);
draw_text(room_width - 152, 24 + 32 * player_number + 12, is_undefined(desc) ? "no controller" : desc);