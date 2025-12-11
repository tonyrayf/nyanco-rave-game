if (draw_setup)
{
	draw_setup = false;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

// Thermal googles
if (thermal_googles_on)
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
		draw_text_transformed(ammo_x, ammo_y, $"{obj_weapon.current_ammo}/{obj_weapon.current_weapon.capacity}", 2.2, 2.2, 0);
	}
	else
	{
		draw_sprite_ext(spr_reload, 0, ammo_x, ammo_y, 1, 1, image_angle--, c_white, 1);
	}
}

if (instance_exists(obj_device) and variable_struct_exists(obj_device.current_device, "current_number"))
{
	image_angle = 0;
	draw_text_transformed(device_x, device_y, $"{obj_device.current_device.current_number}/{obj_device.current_device.total_number}", 2.2, 2.2, 0);
}