// Pick a random color for all the circles:
var color = irandom_range(0, c_white);

// Signaling the right-mouse will update the colors of the circle as well as
// toggle static squares to moving and moving squares to static
signaler.signal("right-mouse", color);