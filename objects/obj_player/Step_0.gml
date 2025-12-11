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


#region States

if (Input.key_crouch_press and place_meeting(x, y + 1, global.solid_objects))
{
	current_state = current_state == player_states.walk ? player_states.crouch : player_states.walk;
}

if (Input.key_run and place_meeting(x, y + 1, global.solid_objects))
{
	current_state = player_states.run;
}
if (Input.key_run_release)
{
	current_state = player_states.walk;
}

switch (current_state)
{
	case player_states.walk: {
		speed_x = clamp(speed_x, top_speed_x_left, top_speed_x_right);
		image_yscale = 1;
		break;
	}
	
	case player_states.run: {
		speed_x = clamp(speed_x, top_speed_x_left * run_multi, top_speed_x_right * run_multi);
		image_yscale = 0.9;
		break;
	}
	
	case player_states.crouch: {
		speed_x = clamp(speed_x, top_speed_x_left * crouch_multi, top_speed_x_right * crouch_multi);
		image_yscale = 0.5;
		break;
	}
}

#endregion

if (direction_x != 0 and alarm_get(2) == -1)
{
	switch (current_state)
	{
		case player_states.walk:	alarm_set(2, step_delay * game_get_speed(gamespeed_fps)); break;
		case player_states.run:		alarm_set(2, crouch_multi * step_delay * game_get_speed(gamespeed_fps)); break;
		case player_states.crouch:	alarm_set(2, run_multi * step_delay * game_get_speed(gamespeed_fps)); break;
	}
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
		
		audio_play_sound(global.jump_sounds[irandom(4)], 100, false);
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
	if (!has_fallen)
	{
		has_fallen = true;
		audio_play_sound(global.land_sounds[irandom(4)], 100, false);
	}
	
	while (!place_meeting(x, y + sign(speed_y), global.solid_objects))
	{
		y += sign(speed_y);
	}
	speed_y = 0;
}
else
{
	has_fallen = false;
}


y += speed_y;


#endregion