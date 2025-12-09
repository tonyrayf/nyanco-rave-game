if (setup)
{
	setup = false;
	
	current_weapon = auto_rifle;
}

if (last_weapon != current_weapon)
{
	last_weapon = current_weapon;
	
	current_ammo = current_weapon.capacity;
	current_spread = current_weapon.min_spread;
}

// smooth spread decrease
current_spread = lerp(current_spread, current_weapon.min_spread, 0.1);

// Shoot
if (alarm_get(0) == -1 and current_ammo > 0 and not is_reloading)
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
			with (instance_create_layer(obj_player.x, obj_player.y, obj_player.layer, obj_bullet))
			{
				// find direction spread in degrees from triangle lengths
				var spread_dir = arctan(_s.current_spread / _s.current_weapon.range) * DEG_PER_RAD;
				var point_dir = point_direction(x, y, obj_shoot_area.x, obj_shoot_area.y);
				direction = random_range(point_dir - spread_dir, point_dir + spread_dir);
				
				// velocity spread is in percents
				var vel = _s.current_weapon.velocity;
				var vel_spread = _s.current_weapon.velocity_spread / 100;
				speed = random_range(vel * (1 - vel_spread), vel * (1 + vel_spread));
				
				image_angle = direction;
				sprite_index = _s.current_weapon.shell_sprite;
				
				damage = _s.current_weapon.damage;
				
				if (variable_struct_exists(_s.current_weapon, "penetrate_probability"))
					penetrate_probability = _s.current_weapon.penetrate_probability;
				
				if (variable_struct_exists(_s.current_weapon, "penetrate_decrease_multi"))
					penetrate_decrease_multi = _s.current_weapon.penetrate_decrease_multi;
			}
		}
		
		current_ammo -= 1;
		current_spread += current_weapon.spread_jump;
		
		do_camera_shake(current_weapon.shake_amplitude, 0.3);
		audio_play_sound(current_weapon.shot_sound.sound, 100, false, 1, 0, current_weapon.shot_sound.pitch);
	}
}

current_spread = clamp(current_spread, current_weapon.min_spread, current_weapon.max_spread);

// Reload
if (Input.key_reload and not is_reloading and current_ammo < current_weapon.capacity)
or (current_ammo <= 0 and not is_reloading)
{
	is_reloading = true;
	
	alarm_set(1, current_weapon.reload_time * game_get_speed(gamespeed_fps));
}