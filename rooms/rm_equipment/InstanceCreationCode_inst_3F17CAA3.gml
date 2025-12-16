step_func = function()
{
	if (place_meeting(x, y, obj_equipment_cursor))
	{
		if (Input.key_shoot_press) room_goto(rm_init);
		
		image_alpha = 0.5;
	}
	else image_alpha = 0.3;
}

draw_func = function()
{
	draw_self();
	draw_set_font(f_main);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	
	draw_text_colour(x, y, "Reset", c_white, c_white, c_white, c_white, 1);
}