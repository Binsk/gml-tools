// Toggles whether we should show a message when the right button is pressed
if (signaler.signal_exists("right-mouse", show_message, "You pressed a thing!"))
    signaler.remove_signal("right-mouse", show_message, "You pressed a thing!");
else
    signaler.add_signal("right-mouse", show_message, "You pressed a thing!");