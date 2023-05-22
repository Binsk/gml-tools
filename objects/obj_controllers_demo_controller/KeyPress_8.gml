// Any reserved slots for the player will be cleared:
input.clear_disconnected(true);
with (obj_controllers_demo_player){
	// Since we set to gray when disconnected, we just use that
	// to determine if they should be destroyed.
	if (player_color == c_gray)
		instance_destroy();
	else
		continue;
	
	if (player_number == other.virtual_player)
		other.virtual_player = -1;
}