/// @dependencies   Signaler

/// ABOUT
/// Some elements need to run at a fixed framerate, regardless as to the actual
/// framerate. This controller does this via signals. Note that it is not perfect
/// and is MOSTLY intended for high-framerate systems. Lagging systems will have
/// multi-process ticks to compensate but it may make the game feel a bit more
/// jittery.
///
/// connect() can be called in order to attach the ticker to local functions,
/// being step_begin_fixed(), step_fixed(), and step_end_fixed(). If the function
/// doesn't exist, it will be ignored.

signaler = new Signaler();

/// @desc	Connects the calling (or specified) instance to the fixed timer.
function connect(instance=other.id){
	if (variable_instance_exists(instance, "step_begin_fixed"))
		signaler.add_signal("tick_begin", method(instance, instance.step_begin_fixed));
	if (variable_instance_exists(instance, "step_fixed"))
		signaler.add_signal("tick", method(instance, instance.step_fixed));
	if (variable_instance_exists(instance, "step_end_fixed"))
		signaler.add_signal("tick_end", method(instance, instance.step_end_fixed));
}

/// @desc	Disconnects the calling (or specified) instance to the fixed timer.
function disconnect(instance=other.id){
	if (variable_instance_exists(instance, "step_begin_fixed"))
		signaler.remove_signal("tick_begin", method(instance, instance.step_begin_fixed));
	if (variable_instance_exists(instance, "step_fixed"))
		signaler.remove_signal("tick", method(instance, instance.step_fixed));
	if (variable_instance_exists(instance, "step_end_fixed"))
		signaler.remove_signal("tick_end", method(instance, instance.step_end_fixed));
}

function get_multiplier(){
	return (current_time - last_tick) / tick_delta;
}

/// @desc	Assigns the target framerate to execute at.
function set_framerate(framerate){
	tick_delta = 1000 / framerate;
}

tick_delta = 1000 / 60; // Desired number of MS per tick (currently set to 60fps target)
last_tick = current_time + 1000; // Wait a second for things to settle
repeat_count = 0;