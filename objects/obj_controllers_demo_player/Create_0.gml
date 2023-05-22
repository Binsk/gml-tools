/// @desc Move the player around
function move(x_axis, y_axis){
	var norm = sqrt(sqr(x_axis) + sqr(y_axis));
	if (norm <= 0)
		return;
	x += x_axis / norm * 10;
	y += y_axis / norm * 10;
}

player_color = c_white;
player_number = -1;