draw_self();
draw_set_color(c_white);
draw_set_alpha(0.2);

// Some trigonometric manipulation
var player_x = obj_player.x;
var player_y = obj_player.y;
var dir = point_direction(player_x, player_y, x, y) * RAD_PER_DEG;
var dir_sin = sin(dir);
var dir_cos = cos(dir);
var delta_x = obj_weapon.current_spread * dir_sin;
var delta_y = obj_weapon.current_spread * dir_cos;
var range = obj_weapon.current_weapon.range;
var circle_x = range * dir_cos;
var circle_y = -range * dir_sin;

// draw shoot area
draw_triangle(player_x, player_y,
	player_x + circle_x - delta_x,
	player_y + circle_y - delta_y,
	player_x + circle_x + delta_x,
	player_y + circle_y + delta_y, false);

draw_set_alpha(1);