active = false;

step_func = function()
{
	if (inst_5948BA.current_w != -1 and inst_511F389A.current_w != -1) active = true;
	
	if (place_meeting(x, y, obj_equipment_cursor) and active)
	{
		if (Input.key_shoot_press)
		{
			obj_weapon.mods_setup = true;
			instance_activate_object(obj_fade);
		}
		
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
	
	draw_text_colour(x, y, "Ready", c_white, c_white, c_white, c_white, active ? 1 : 0.6);
}