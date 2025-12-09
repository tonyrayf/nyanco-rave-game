#region X

var step_over = false;  //step over small ledges
if (place_meeting(x + speed_x, y, global.solid_objects)) //Collision check
{
	var i = 1; var step_over_maximum = 10;  //ledge max height to step over
	repeat (step_over_maximum) //Check for small ledge
	{
		if (!place_meeting(x + speed_x, y - i, global.solid_objects))
		{
			y -= i;
			step_over = true;
			break;
		} i += 1;
	}
	if (!step_over) //no need to check for collision if already stepped over the ledge
	{
		while (!place_meeting(x + sign(speed_x), y, global.solid_objects))
		{
			x += sign(speed_x);
		}
		speed_x = 0;
	}
}


x += speed_x;

#endregion
#region Y

speed_y += acceleration_g;

if (place_meeting(x, y + speed_y, global.solid_objects)) //Collision check
{
	while (!place_meeting(x, y + sign(speed_y), global.solid_objects))
	{
		y += sign(speed_y);
	}
	speed_y = 0;
}


y += speed_y;

#endregion