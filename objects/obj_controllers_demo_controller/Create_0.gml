#region PROPERTIES
player_colors = [c_red, c_green, c_blue, c_purple];
virtual_player = -1;	// Used to track our virtual player's number
#endregion

#region METHODS
// When a player connects, create an instance for them and connect 
// the controller's left-joy to their movement code.
function player_connected(player_index){
	with (instance_create_depth(irandom_range(48, room_width - 48), irandom_range(48, room_height - 48), 0, obj_controllers_demo_player)){
		player_number = player_index;
		player_color = other.player_colors[player_index];
		
		other.input.signaler.add_signal(string_ext("joystick.left.axis:{0}", [player_index]), method(id, move));
		
		// An example of setting the player's controller's deadzone:
		var controller_slot = other.input.get_player_slot(player_index);
		if (controller_slot >= 0) // Virtual controllers have slot numbers of -1; skip those
			gamepad_set_axis_deadzone(controller_slot, 0.5);
	}
}

// When a player re-connects put their color back to 'connected':
function player_reconnected(player_index){
	with (obj_controllers_demo_player){
		if (player_number == player_index){
			player_color = other.player_colors[player_index];
			return;
		}
	}
}

function player_disconnected(player_index){
	// Because we 'reserve slots' for the player to reconnect, we keep the player
	// but just discolor to show they are disconnected
	with (obj_controllers_demo_player){
		if (player_number != player_index)
			continue;
		
		player_color = c_gray;
	}
}

// If a player's slot has changed then, in the case of this example, we need to
// reconnect the signals with the new slot number. We also need to update the color
// to match the new player color.
function slot_changed(from, to){
	with (obj_controllers_demo_player){
		if (player_number != from) continue;
		
		player_number = to;
		player_color = other.player_colors[player_number];
		
		// This is how to remove the specific signal; initialization arguments are required if they exist
		other.input.signaler.remove_signal(string_ext("joystick.left.axis:{0}", [from]), method(id, move));
		// If you wish to remove ALL signals for this instance you can call the following commented out line:
		// other.input.signaler.clear_instance(id);
		
		other.input.signaler.add_signal(string_ext("joystick.left.axis:{0}", [to]), method(id, move));
	}
}

/// Our 'virtual controller' will use the arrow keys so we will need to manually process
/// this in our own function to send back to the controller manager.
function virtual_input(_player_index, input_state){
	// 'input_state' will be a cleared input state for us to modify
	// and return back to the controller system
	
	// Add our inputs to the places we care about:
	input_state.joystick.left.axis_x = real(keyboard_check(vk_right) - keyboard_check(vk_left));
	input_state.joystick.left.axis_y = real(keyboard_check(vk_down) - keyboard_check(vk_up));
	// Return the new state:
	return input_state;
	
	// NOTE: If an input is digital, the value should be an int64().
	//		 If the input is analog, the value should be a real().
}
#endregion

#region INIT
input = instance_create_depth(0, 0, 0, obj_controller_manager);
input.set_maximum_connections(4); // Allow only 4 controllers
input.set_scan_refresh_rate(1000);// Scan for controllers every 1 second
input.signaler.add_signal("connected", method(id, player_connected));
input.signaler.add_signal("reconnected", method(id, player_reconnected));
input.signaler.add_signal("disconnected", method(id, player_disconnected));
input.signaler.add_signal("slot-changed", method(id, slot_changed));

// Set our function to handle processing 'inputs' of our virtual controllers (if any)
input.set_virtual_input_function(method(id, virtual_input));
#endregion