// Velocity is updated in the fixed timer at 60fps, however our position can 
// update in delta-time to give a smoother experience across framerates.
x += velocity_x * (delta_time / 1000000);
y += velocity_y * (delta_time / 1000000);

// Treat the bottom of the room as the 'floor'
if (y >= room_height and velocity_y >= 0){
	y = room_height;
	velocity_y = 0;
}

// Prevent leaving the room:
x = clamp(x, 32, room_width - 32);

// Handle jumping:
if (keyboard_check_pressed(vk_up) and y >= room_height)
	velocity_y = -512;