// Create a square:
if (keyboard_check(vk_shift)){
    var square = instance_create_depth(mouse_x, mouse_y, 0, obj_signalers_demo_square);
    
    // Attach a signal to change the movement state of the square:
    signaler.add_signal("right-mouse", method(square, function(){
        is_moving = not is_moving;
    }));
}
// Create a circle:
else{
    var circle = instance_create_depth(mouse_x, mouse_y, 0, obj_signalers_demo_circle);
    
    // Attach a signal to change the color when the right button is pressed.
    // We will give it a default value of 'white' if nothing is explicitly passed:
    signaler.add_signal("right-mouse", method(circle, function(color){
        self.color = color;
    }), c_white);
}