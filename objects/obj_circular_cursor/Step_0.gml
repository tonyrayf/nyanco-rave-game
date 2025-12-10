angle = point_direction(obj_player.x, obj_player.y, x + Mouse.speed_x + obj_player.speed_x, y + Mouse.speed_y);

if (angle > 360) angle -= 360;
if (angle < 0) angle += 360;

x = obj_player.x + radius * cos(degtorad(angle));
y = obj_player.y - radius * sin(degtorad(angle));