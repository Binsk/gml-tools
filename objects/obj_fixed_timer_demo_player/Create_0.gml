#region PROPERTIES
velocity_x = 0;	// In units / second
velocity_y = 0;
gravity_strength = 24;
#endregion

#region METHODS
// This function will be attached to the fixed timer and executed at 60fps.
function step_fixed(){
	// Handle left / right movement:
	var delta_x = -keyboard_check(vk_left) + keyboard_check(vk_right);
	if (delta_x == 0)
		velocity_x = lerp(velocity_x, 0, 0.15); // Lerp to simulate simple friction
	else
		velocity_x = delta_x * 192;
	
	if (y < room_height)
		velocity_y += gravity_strength;
}
#endregion

#region INIT
// Auto connects our *_fixed() methods to be called at a 60fps tick
obj_fixed_timer.connect();
#endregion