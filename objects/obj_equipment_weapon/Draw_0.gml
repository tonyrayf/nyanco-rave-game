draw_self();

if (suppressor) draw_sprite_ext(spr_suppressor, 0, bbox_right, y, 2, 2, 0, c_white, 1);
if (laser)
{
	var dx = -30;
	var dy = 0;

	if (sprite_index == spr_pistol_right)
	{
		dx = -17;
		dy = 13;
	}
	else if (sprite_index == spr_kilo_right)
	{
		dx = -42;
		dy = 2;
	}
	
	draw_sprite_ext(spr_laser, 0, bbox_right + dx, y + dy, 2, 2, 0, c_white, 1);
}
if (ricochet) draw_sprite_ext(spr_ricochet_bullet, 0, bbox_right, bbox_bottom, 2, 2, 90, c_white, 1);
if (extended_mag) draw_sprite_ext(spr_extended_mag, 0, bbox_right + 25, bbox_bottom, 2, 2, 0, c_white, 1);