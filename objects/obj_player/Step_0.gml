#region X


direction_x = (Input.key_right - Input.key_left) * can_move;


//Smooth movement
if (current_state != player_states.slide)
{

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

var state_jump = true;

// States condition
if (speed_y == 0)
{
	if (speed_x == 0) current_state = player_states.idle;
	else current_state = player_states.walk;
}

if (current_state != player_states.slide and speed_y == 0)
{	
	if (Input.key_run)
		current_state = player_states.run;
	
	if (Input.key_run and Input.key_crouch_press)
		current_state = player_states.slide;
	
	if (!Input.key_run and Input.key_crouch_press)
		current_state = current_state == player_states.walk ? player_states.crouch : player_states.walk;
	
	if (Input.key_run_release)
		current_state = player_states.walk;
}
else if (Input.key_crouch_press or Input.key_jump_press)
{
	state_jump = false;
	current_state = player_states.walk;
	audio_play_sound(snd_slide_stop, 100, false);
}
if (Input.key_jump_press and current_state == player_states.crouch)
{
	state_jump = false;
	current_state = player_states.walk;
}

if (current_state == player_states.run and last_direction_x != obj_shoot_area.direction_x)
	current_state = player_states.walk;

// Execute state
switch (current_state)
{
	case player_states.idle: {
		if (!Input.key_shoot)
		{
			current_animcurve = ac_idle;
			current_animcurve_duration = 2;
		}
		else
		{
			current_animcurve = -1;
			current_animcurve_duration = -1;	
		}
		break;
	}
	case player_states.walk: {
		speed_x = obj_shoot_area.direction_x == RIGHT
			? clamp(speed_x, -top_speed_x_back, top_speed_x_forward)
			: clamp(speed_x, -top_speed_x_forward, top_speed_x_back);
		
		image_yscale = start_yscale;
		
		current_animcurve = -1;
		current_animcurve_duration = -1;
		break;
	}
	
	case player_states.run: {
		speed_x = obj_shoot_area.direction_x == RIGHT
			? clamp(speed_x, -top_speed_x_back, top_speed_x_forward * run_multi)
			: clamp(speed_x, -top_speed_x_forward * run_multi, top_speed_x_back);
		
		image_yscale = start_yscale * 0.9;
		
		current_animcurve = -1;
		current_animcurve_duration = -1;
		break;
	}
	
	case player_states.crouch: {
		speed_x = obj_shoot_area.direction_x == RIGHT
			? clamp(speed_x, -top_speed_x_back * crouch_multi, top_speed_x_forward * crouch_multi)
			: clamp(speed_x, -top_speed_x_forward * crouch_multi, top_speed_x_back * crouch_multi);
		
		image_yscale = start_yscale * 0.7;
		state_jump = false;
		
		current_animcurve = -1;
		current_animcurve_duration = -1;
		break;
	}
	case player_states.slide: {
		var slide_dir = sign(speed_x);
        if (slide_dir != 0)
		{
            speed_x = slide_dir * top_speed_x_forward * run_multi;  // мощный слайд
        }
		
		if (alarm_get(3) == -1)
		{
			alarm_set(3, 1 * game_get_speed(gamespeed_fps));
			audio_play_sound(snd_slide, 100, false);
		}
		
		image_yscale = start_yscale * 0.4;
		state_jump = false;
		break;
	}
}

#endregion

if (direction_x != 0 and speed_y == 0 and alarm_get(2) == -1)
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
if (can_jump and !place_meeting(x, y - 1, global.solid_objects) and state_jump)
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
		
		current_animcurve = ac_jump;
		current_animcurve_duration = 0.35;
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

aim_origin_y = bbox_top + 60;

#endregion

if (hp <= 0)
{
	instance_create_depth(0, 0, 0, obj_lose);
	instance_destroy();	
}

if (obj_shoot_area.direction_x == RIGHT) image_index = 1;
else image_index = 0;

if (current_animcurve_duration != -1 and alarm_get(4) == -1)
{
	alarm_set(4, current_animcurve_duration * game_get_speed(gamespeed_fps));	
}

if (current_animcurve != -1)
{
	var time = alarm_get(4) / current_animcurve_duration / game_get_speed(gamespeed_fps);
	image_xscale = animcurve_channel_evaluate(animcurve_get_channel(current_animcurve, "xscale"), time);
	image_yscale = animcurve_channel_evaluate(animcurve_get_channel(current_animcurve, "yscale"), time);
}
else
{
	image_xscale += (1 - image_xscale) * 0.5;
	image_yscale += (1 - image_yscale) * 0.5;
}