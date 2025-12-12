#region Weapons

pistol = {
	silent : false,
	damage : 30,
	fire_rate : 1000,			// rounds/minute
	current_ammo : 8,
	capacity : 8,				// max ammo
	reload_time : 0.7,			// in seconds
	auto : false,
	velocity : 40,				// px/step
	velocity_spread : 0,		// in percents
	shells_in_shot : 1,
	min_spread : 8,				// in pixels
	max_spread : 60,			// in pixels
	spread_jump : 30,			// px/step
	spread_lerp : 0.1,			
	range : 500,				// in pixels
	shot_sound : {
		sound : snd_smg,
		pitch : 1,
		gain : 1
	},
	
	shell_sprite : spr_9mm_bullet,
	weapon_sprite_right : spr_pistol_right,
	weapon_sprite_left : spr_pistol_left,
	
	shake_amplitude : 2,
}

smg = {
	silent : false,
	damage : 25,
	fire_rate : 600,
	current_ammo : 40,
	capacity : 40,
	reload_time : 1.4,
	auto : true,
	velocity : 40,
	velocity_spread : 0,
	shells_in_shot : 1,
	min_spread : 12,
	max_spread : 100,
	spread_jump : 40,
	spread_lerp : 0.2,
	range : 500,
	shot_sound : {
		sound : snd_smg,
		pitch : 1,
		gain : 0.6
	},
	
	shell_sprite : spr_9mm_bullet,
	weapon_sprite_right : spr_iso_right,
	weapon_sprite_left : spr_iso_left,
	
	shake_amplitude : 2,
}

auto_rifle = {
	silent : false,
	damage : 40,
	fire_rate : 400,
	current_ammo : 30,
	capacity : 30,
	reload_time : 1.7,
	auto : true,
	velocity : 50,
	velocity_spread : 0,
	shells_in_shot : 1,
	min_spread : 12,
	max_spread : 60,
	spread_jump : 20,
	spread_lerp : 0.2,
	range : 700,
	shot_sound : {
		sound : snd_arsup_shoot,
		pitch : 1.2,
		gain : 1
	},
	
	shell_sprite : spr_ar_bullet,
	weapon_sprite_right : spr_kilo_right,
	weapon_sprite_left : spr_kilo_left,
	
	shake_amplitude : 3,
	penetrate_probability : 20,
}

sniper_rifle = {
	silent : false,
	damage : 100,
	fire_rate : 60,
	current_ammo : 5,
	capacity : 5,
	reload_time : 2.2,
	auto : false,
	velocity : 60,
	velocity_spread : 0,
	shells_in_shot : 1,
	min_spread : 10,
	max_spread : 10,
	spread_jump : 0,
	spread_lerp : 1,
	range : 900,
	shot_sound : {
		sound : snd_sniper,
		pitch : 1,
		gain : 1
	},
	
	shell_sprite : spr_lapua_bullet,
	weapon_sprite_right : spr_spr_right,
	weapon_sprite_left : spr_spr_left,
	
	shake_amplitude : 4,
	penetrate_probability : 80,			// in percents
	penetrate_decrease_multi : 1.25,	// after every penetration prob. decreases
}

shotgun = {
	silent : false,
	damage : 10,
	fire_rate : 80,
	current_ammo : 7,
	capacity : 7,
	reload_time : 2.2,
	auto : false,
	velocity : 40,
	velocity_spread : 5,
	shells_in_shot : 20,
	min_spread : 70,
	max_spread : 70,
	spread_jump : 0,
	spread_lerp : 1,
	range : 400,
	shot_sound : {
		sound : snd_shotgun,
		pitch : 1,
		gain : 1
	},
	
	shell_sprite : spr_pellete,
	weapon_sprite_right : spr_shotgun_right,
	weapon_sprite_left : spr_shotgun_left,
	
	shake_amplitude : 5,
	effective_range : 2500,
}

admin_gun = {
	silent : true,
	damage : 1000,
	fire_rate : 800,
	capacity : 999,
	reload_time : 0.1,
	auto : true,
	velocity : 60,
	velocity_spread : 10,
	shells_in_shot : 50,
	min_spread : 120,
	max_spread : 120,
	spread_jump : 0,
	spread_lerp : 1,
	range : 1000,
	shot_sound : {
		sound : snd_shotgun,
		pitch : 1,
		gain : 1,
	},
	shell_sprite : spr_pellete,
	shake_amplitude : 5,
	penetrate_probability : 100,
	
	weapon_sprite_right : spr_kilo_right,
	weapon_sprite_left : spr_kilo_left,
}

admin_gun2 = {
	silent : false,
	damage : 1000,
	fire_rate : 800,
	capacity : 999,
	reload_time : 0.1,
	auto : true,
	velocity : 60,
	velocity_spread : 0,
	shells_in_shot : 1,
	min_spread : 0,
	max_spread : 0,
	spread_jump : 0,
	spread_lerp : 1,
	range : 1000,
	shot_sound : {
		sound : snd_shotgun,
		pitch : 1,
		gain : 1
	},
	
	shell_sprite : spr_lapua_bullet,
	weapon_sprite_right : spr_shotgun_right,
	weapon_sprite_left : spr_shotgun_left,
	
	shake_amplitude : 0,
	penetrate_probability : 100,
	current_shell : obj_ricochet_bullet,
}

#endregion

#region Modifications

suppressor = {
	draw_func : function () {
		with (obj_weapon)
		{
			draw_sprite_ext (
				spr_suppressor, 0,
				sight_x, sight_y,
				sign(obj_shoot_area.x - obj_weapon.x), 1,
				image_angle, c_white, 1
			);
		}
	},
	step_func : function () {
	},
	change_func : function (weapon) {
		weapon.silent = true;
		
		return weapon;
	}
}

ricochet_ammo = {
	draw_func : function () {
	},
	step_func : function () {
	},
	change_func : function (weapon) {
		weapon.fire_rate /= 2;
		weapon.max_spread /= 1.25;
		weapon.min_spread /= 1.25;
		weapon.current_shell = obj_ricochet_bullet;
		weapon.shake_amplitude = 0.5;
		weapon.shell_sprite = spr_ricochet_bullet;
		
		return weapon;
	}
}

#endregion

#region Devices

impact_grenade = {
	// Общие параметры
	cooldown : 3,    // в секундах
    total_number : 4,
	current_number : 4,
	
	// Так как девайсы очень разные по применению и функционалу
	// у каждого полностью своя функция применения
    handle_device_interaction : function()
    {
		// Вычисление траектории
        if (Input.key_device)
        {
            weapon_set_active(false);
			
			if (trajectory_inst == noone)
			{
				trajectory_inst = instance_create_layer(0, 0, obj_player.layer, obj_throw_devices_trajectory);
				trajectory_inst.throw_speed = throw_speed;
				trajectory_inst.throw_gravity = throw_gravity;
			}
			
			throw_direction = trajectory_inst.throw_direction;
		}
		// Бросание гранаты
        if (Input.key_device_release)
        {
			var cldwn = cooldown;
			with (obj_device)
			{
				alarm_set(0, cldwn * game_get_speed(gamespeed_fps));
				current_device.current_number -= 1;
			}
						
            weapon_set_active(true);
			
			obj_shoot_area.x = trajectory_inst.x;
			obj_shoot_area.y = trajectory_inst.y;
			
			instance_destroy(trajectory_inst);
			trajectory_inst = noone;
			
			var _s = self;
			with (instance_create_layer(obj_player.x, obj_player.bbox_top + 60, obj_player.layer, grenade))
			{
				direction = _s.throw_direction;
				speed = _s.throw_speed;
				gravity = _s.throw_gravity;
			}
        }
    },
	
	// Индивидуальные параметры
	trajectory_inst : noone,
	throw_speed : 22.5,
	throw_gravity : 0.5,
	throw_direction : 0,
	grenade : obj_impact_grenade
}

thermal_googles = {
	current_number : 1,
	total_number : infinity,
	cooldown : 1.3,
	
	handle_device_interaction : function()
	{
		if (Input.key_device_press)
		{
			GUI.thermal_googles_on = !GUI.thermal_googles_on;
			
			audio_play_sound(GUI.thermal_googles_on ? snd_night_vision_on : snd_night_vision_off, 100, false, 1);
		
			var cldwn = cooldown;
			with (obj_device)
			{
				alarm_set(0, cldwn * game_get_speed(gamespeed_fps));
			}
		}
	},
}

#endregion