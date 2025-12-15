if (!instance_exists(obj_player)) exit;

if (draw_setup)
{
	draw_setup = false;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_set_font(f_main);
}

// Thermal goggles
layer_set_visible("BG", !thermal_goggles_on);
if (thermal_goggles_on)
{
	shader_set(sh_thermal);
	shader_set_uniform_f(shader_get_uniform(sh_thermal, "u_time"), current_time * 0.001);
	draw_surface(application_surface, 0, 0);
	shader_reset();
}

// Ammunition
if (instance_exists(obj_weapon))
{
	if (obj_weapon.alarm[1] == -1)
	{
		image_angle = 0;
		draw_text(ammo_x, ammo_y, $"{obj_weapon.current_weapon.current_ammo}/{obj_weapon.current_weapon.capacity}");
	}
	else
	{
		draw_sprite_ext(spr_reload, 0, ammo_x, ammo_y, 1, 1, image_angle--, c_white, 1);
	}
}

if (instance_exists(obj_device) and variable_struct_exists(obj_device.current_device, "current_number"))
{
	image_angle = 0;
	draw_text(device_x, device_y, $"{obj_device.current_device.current_number}/{obj_device.current_device.total_number}");
}

draw_text(hp_x, hp_y, obj_player.hp);