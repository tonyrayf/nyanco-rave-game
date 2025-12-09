#region X


direction_x = (Input.key_right - Input.key_left) * can_move;


//Smooth movement
if (direction_x != 0)
{
	speed_x += acceleration_x * direction_x;
	last_direction_x = direction_x;
}
else if (can_decelerate)
{
	if (sign(speed_x) == last_direction_x) speed_x += -deceleration_x * last_direction_x;
	
	else speed_x = 0;  //if speed becomes negative, set it to zero
}


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


// Run
if (Input.key_run and place_meeting(x, y + 1, global.solid_objects))
{
	speed_x = clamp(speed_x, top_speed_x_left * run_multiplier, top_speed_x_right * run_multiplier);
}
else
{
	speed_x = clamp(speed_x, top_speed_x_left, top_speed_x_right);
}


x += speed_x;

#endregion
#region Y

speed_y += acceleration_g;


//Jump
if (can_jump and !place_meeting(x, y - 1, global.solid_objects))
{
	//Late jump
	if (place_meeting(x, y + 1, global.solid_objects))
		alarm_set(alarms.late_jump, 0.1 * game_get_speed(gamespeed_fps)); //explanation in alarm
	
	//Early jump
	if (Input.key_jump_press)
		alarm_set(alarms.early_jump, 0.1 * game_get_speed(gamespeed_fps)); //explanation in alarm
	
	
	//Jump activation
	if (Input.key_jump_press and alarm_get(alarms.late_jump) >= 0)
	or (place_meeting(x, y + 1, global.solid_objects) and alarm_get(alarms.early_jump) >= 0)
	{
		speed_y = -jump_start_speed;
		alarm_set(alarms.late_jump, 0);
		alarm_set(alarms.early_jump, 0);
	}
	
	//Velocity Cut
	if (Input.key_jump_release and speed_y < 0)
	{
		speed_y *= 0.5;
		//if key jump release, then speed is divided by 2
	}
}


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