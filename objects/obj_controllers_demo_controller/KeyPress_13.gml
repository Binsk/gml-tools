/// Connect a virtual controller for testing; this will allow you to use the keyboard
/// arrows to control the new player(s)

// If already created, just toggle connection state
if (virtual_player >= 0){
	
	// NOTE: These disconnect_/reconnect_ functions are really only useful for
	//		 virtual controllers. All this is done automatically with actual controllers.
	if (input.get_player_state(virtual_player) == CONTROLLERMAP_STATE.connected)
		input.disconnect_player(virtual_player);
	else 
		input.connect_player(virtual_player);
}
// If NOT already created, create it:
else
	virtual_player = input.connect_virtual_controller();