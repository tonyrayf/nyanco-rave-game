if (!active) exit;

draw_self();

draw_sprite_ext (
	spr_suppressor, 0,
	sight_x, sight_y,
	sign(obj_shoot_area.x - obj_weapon.x), 1,
	image_angle, c_white, 1
);