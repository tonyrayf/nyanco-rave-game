event_inherited();

radius = 200;

angle = point_direction(obj_player.x, obj_player.y, obj_shoot_area.x, obj_shoot_area.y);

x = obj_player.x + radius * cos(degtorad(angle));
y = obj_player.y - radius * sin(degtorad(angle));

throw_speed = 0;
throw_gravity = 0;
throw_direction = 0;