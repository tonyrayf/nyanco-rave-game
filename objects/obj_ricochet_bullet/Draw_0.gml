draw_self();

var i = max(0, array_length(_x) - trail_number);
repeat (array_length(_x) - i)
{
	draw_circle_colour(_x[i], _y[i], 1, c_purple, c_maroon, true);
	++i;
}

array_push(_x, x);
array_push(_y, y);