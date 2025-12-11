draw_set_color(c_white);
draw_set_alpha(0.8);

var sight_x = obj_player.x;
var sight_y = obj_player.bbox_top + 60;
throw_direction = point_direction(sight_x, sight_y, x, y);
var dir = degtorad(throw_direction);

// Some trigonometric manipulations
var dir_sin = -sin(dir);
var dir_cos = cos(dir);
var delta_x = 100 * dir_cos;
var delta_y = 100 * dir_sin;

// Draw arrow
draw_arrow(sight_x, sight_y, sight_x + delta_x, sight_y + delta_y, 20);

// Simulating flight of throwable
var sim_x = sight_x;
var sim_y = sight_y;
var sim_speed_x = throw_speed * dir_cos;
var sim_speed_y = throw_speed * dir_sin;

repeat (150)
{
	if (instance_place(sim_x, sim_y, global.solid_objects) != noone) break;
	
    sim_speed_y += throw_gravity;
    sim_x += sim_speed_x;
    sim_y += sim_speed_y;
    
    draw_circle(sim_x, sim_y, 2, false);
}

draw_set_alpha(1);