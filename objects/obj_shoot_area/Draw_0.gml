if (!active) exit;

draw_self();
draw_set_color(c_white);
draw_set_alpha(0.2);

// Some trigonometric manipulations
var sight_x = obj_player.x;
var sight_y = obj_player.y - 20;
var dir = point_direction(sight_x, sight_y, x, y) * RAD_PER_DEG;
var dir_sin = sin(dir);
var dir_cos = cos(dir);
var delta_x = obj_weapon.current_spread * dir_sin;
var delta_y = obj_weapon.current_spread * dir_cos;
var range = obj_weapon.current_weapon.range;
var circle_x = range * dir_cos;
var circle_y = -range * dir_sin;

// draw shoot area
draw_triangle(sight_x, sight_y,
	sight_x + circle_x - delta_x,
	sight_y + circle_y - delta_y,
	sight_x + circle_x + delta_x,
	sight_y + circle_y + delta_y, false);

draw_set_alpha(1);