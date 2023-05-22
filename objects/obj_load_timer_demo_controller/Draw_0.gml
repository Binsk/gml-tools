draw_set_color(c_white);
draw_set_alpha(1.0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_text(24, 24, "FPS: " + string(fps) + " / " + string(room_speed));
draw_text(24, 24, string_ext("\nMax frametime: {0} (ms)", [floor(max_frametime)]));
draw_text(24, 24, "\n\n'space' to begin an expensive processing task\n'up/down' arrows to change allotted frametime\n'enter' to cancel remaining tasks");

var percentage = loader.get_percentage_complete();
if (percentage >= 1.0) // If done, don't bother rendering bar
	return;
	
// Draw a simple 'processing' bar:
var cx = room_width * 0.5;
var cy = room_height * 0.5;
var extend_x = 256;
var extend_y = 24;
draw_rectangle_color(cx - extend_x, cy - extend_y, cx + extend_x, cy + extend_y, c_white, c_white, c_white, c_white, true);
draw_rectangle_color(cx - extend_x + 2, cy - extend_y + 2, cx - extend_x + 2 + (extend_x * 2 - 4) * percentage, cy + extend_y - 2, c_white, c_white, c_white, c_white, false);

// Draw loading bar text containing current task name and overall percentage
// completed of all tasks.
// Shader is unnecessary; simply used for text color.
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
shader_set(shd_load_timer_demo_text);
shader_set_uniform_f(shader_get_uniform(shd_load_timer_demo_text, "u_fCutoffX"), cx - extend_x + 2 + (extend_x * 2 - 4) * percentage);
draw_text(cx, cy, string_ext("{0} {1}%", [loader.get_active_task(), floor(percentage * 100)]));
shader_reset();