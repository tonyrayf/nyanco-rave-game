if (!active or !instance_exists(obj_player)) exit;

direction = point_direction(x, y, obj_shoot_area.x, obj_shoot_area.y) - camera_get_view_angle(view_camera[0]) * 2;
dir_cos = cos(degtorad(direction));
dir_sin = sin(degtorad(direction));

#region Weapon action

if (mods_setup)
{
	mods_setup = false;
	
	var i = 0;
	repeat (array_length(first_w_mods))
	{
		first_weapon = first_w_mods[i++].change_func(first_weapon);
	}
	
	i = 0;
	repeat (array_length(second_w_mods))
	{
		second_weapon = second_w_mods[i++].change_func(second_weapon);
	}
}

if (!is_reloading)
{
	if (Input.key_first_weapon)
{
	current_weapon = first_weapon;
	current_mods = first_w_mods;
}
	else if (Input.key_second_weapon)
{
	current_weapon = second_weapon;
	current_mods = second_w_mods;
}
}

if (last_weapon != current_weapon)
{
	last_weapon = current_weapon;
	
	current_spread = current_weapon.min_spread;
	
	sprite_index = current_weapon.weapon_sprite_right;
	barrel_dist = abs(sprite_width - sprite_get_xoffset(sprite_index) * image_xscale);
	
	if (abs(x - obj_shoot_area.x) <= barrel_dist)
	{
		var length = (barrel_dist + 20);
		obj_shoot_area.x = x + length * dir_cos;
		obj_shoot_area.y = y - length * dir_sin;
	}
}

// smooth spread decrease
current_spread = lerp(current_spread, current_weapon.min_spread, 0.1);

// Shoot
if (alarm_get(0) == -1 and current_weapon.current_ammo > 0 and not is_reloading)
{
	if (Input.key_shoot_press and not current_weapon.auto)
	or (Input.key_shoot and current_weapon.auto)
	{
		// fire rate is in RPM, so formula is fps / fire_rate * 60 sec/min
		alarm_set(0, game_get_speed(gamespeed_fps) / current_weapon.fire_rate * 60);
		
		// create instances of bullets shells in shot times
		var _s = self;
		repeat (current_weapon.shells_in_shot)
		{
			var shell = !variable_struct_exists(current_weapon, "current_shell") ? obj_bullet : current_weapon.current_shell;
			
			with (instance_create_layer(sight_x, sight_y, obj_player.layer, shell))
			{
				// find direction spread in degrees from triangle lengths
				var spread_dir = arctan(_s.current_spread / _s.current_weapon.range) * DEG_PER_RAD;
				direction = random_range(_s.direction - spread_dir, _s.direction + spread_dir);
				
				// velocity spread is in percents
				var vel = _s.current_weapon.velocity;
				var vel_spread = _s.current_weapon.velocity_spread / 100;
				start_speed = random_range(vel * (1 - vel_spread), vel * (1 + vel_spread));
				speed = start_speed;
				
				image_angle = direction;
				sprite_index = _s.current_weapon.shell_sprite;
				
				start_damage = _s.current_weapon.damage;
				damage = start_damage;
				
				if (variable_struct_exists(_s.current_weapon, "effective_range"))
					effective_range = _s.current_weapon.effective_range;
				
				if (variable_struct_exists(_s.current_weapon, "penetrate_probability"))
					penetrate_probability = _s.current_weapon.penetrate_probability;
				
				if (variable_struct_exists(_s.current_weapon, "penetrate_decrease_multi"))
					penetrate_decrease_multi = _s.current_weapon.penetrate_decrease_multi;
			}
		}
		
		// eject casing
		with (instance_create_depth(x + barrel_dist / 2 * dir_cos, y - barrel_dist / 2 * dir_sin, depth - 1 , obj_casing))
		{
			speed_x = random_range(-3, 3);
			speed_y = 2.5;
		}
		
		current_weapon.current_ammo -= 1;
		current_spread += current_weapon.spread_jump;
		
		do_camera_shake(current_weapon.shake_amplitude, 0.3);
		
		var snd = !current_weapon.silent ? current_weapon.shot_sound : current_weapon.shot_sup_sound;
		audio_play_sound(snd.sound, 100, false, snd.gain, 0, snd.pitch);
		audio_play_sound(snd_weap, 100, false, 0.5);
	}
}

current_spread = clamp(current_spread, current_weapon.min_spread, current_weapon.max_spread);

// Reload
if (Input.key_reload and not is_reloading and current_weapon.current_ammo < current_weapon.capacity)
or (current_weapon.current_ammo <= 0 and not is_reloading)
{
	is_reloading = true;
	
	alarm_set(1, current_weapon.reload_time * game_get_speed(gamespeed_fps));
	
	if (variable_struct_exists(current_weapon, "reload_sound")) audio_play_sound(current_weapon.reload_sound, 100, false, 0.2);
}

#endregion

#region Weapon view

x = obj_shoot_area.direction_x == RIGHT ? obj_player.bbox_right - origin_offset : obj_player.bbox_left + origin_offset;
y = obj_player.aim_origin_y;

sight_x = x + barrel_dist * dir_cos;
sight_y = y - barrel_dist * dir_sin;

image_angle = direction - (obj_shoot_area.direction_x == RIGHT ? 0 : 180);

sprite_index = obj_shoot_area.direction_x == RIGHT ? current_weapon.weapon_sprite_right : current_weapon.weapon_sprite_left;

#endregion

var i = 0;
repeat (array_length(current_mods))
{
	current_mods[i++].step_func();
}