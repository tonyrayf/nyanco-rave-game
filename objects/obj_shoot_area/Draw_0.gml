if (!active) exit;

draw_self();
draw_set_color(c_white);
draw_set_alpha(0.2);

// Some trigonometric manipulations
var dir = degtorad(point_direction(obj_weapon.x, obj_weapon.y, x, y));
var sight_x = obj_weapon.sight_x;
var sight_y = obj_weapon.sight_y;
var dir_sin = sin(dir);
var dir_cos = cos(dir);
var delta_x = obj_weapon.current_spread * dir_sin;
var delta_y = obj_weapon.current_spread * dir_cos;
var range = obj_weapon.current_weapon.range;
var circle_x = range * dir_cos;
var circle_y = -range * dir_sin;

// Draw shoot area
draw_triangle(sight_x, sight_y,
	sight_x + circle_x - delta_x,
	sight_y + circle_y - delta_y,
	sight_x + circle_x + delta_x,
	sight_y + circle_y + delta_y, false);

draw_set_alpha(1);