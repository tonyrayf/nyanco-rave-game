if (draw_setup)
{
	draw_setup = false;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}

if (not is_reloading)
{
	image_angle = 0;
	draw_text_transformed(ammo_x, ammo_y, $"{current_ammo}/{current_weapon.capacity}", 2.2, 2.2, 0);
}
else
{
	draw_sprite_ext(spr_reload, 0, ammo_x, ammo_y, 1, 1, image_angle--, c_white, 1);
}