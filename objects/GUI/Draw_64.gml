if (draw_setup)
{
	draw_setup = false;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

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


if (instance_exists(obj_device))
{
	image_angle = 0;
	draw_text_transformed(device_x, device_y, $"{obj_device.current_number}/{obj_device.current_device.capacity}", 2.2, 2.2, 0);
}