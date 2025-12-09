if (!layer_sequence_exists(layer, seq))
{
	instance_destroy();
}

#region X

var step_over = false;  //step over small ledges
if (place_meeting(x + speed_x, y, obj_block_solid)) //Collision check
{
	var i = 1; var step_over_maximum = 10;  //ledge max height to step over
	repeat (step_over_maximum) //Check for small ledge
	{
		if (!place_meeting(x + speed_x, y - i, obj_block_solid))
		{
			y -= i;
			step_over = true;
			break;
		} i += 1;
	}
	if (!step_over) //no need to check for collision if already stepped over the ledge
	{
		while (!place_meeting(x + sign(speed_x), y, obj_block_solid))
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

if (place_meeting(x, y + speed_y, obj_block_solid)) //Collision check
{
	while (!place_meeting(x, y + sign(speed_y), obj_block_solid))
	{
		y += sign(speed_y);
	}
	speed_y = 0;
}

y += speed_y;

#endregion

// Move sequence
layer_sequence_x(seq, x);
layer_sequence_y(seq, y);