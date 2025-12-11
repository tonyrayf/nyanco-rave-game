if (place_meeting(x + speed_x, y, global.solid_objects))
{
	while (!place_meeting(x + sign(speed_x), y, global.solid_objects)) x += sign(speed_x);
	speed_x = 0;
}

x += speed_x;

speed_y += acceleration_g;

if (place_meeting(x, y + speed_y, global.solid_objects))
{
	while (!place_meeting(x, y + sign(speed_y), global.solid_objects)) y += sign(speed_y);
	speed_y = 0;
	speed_x = 0;
}

y += speed_y;