if (!active or !instance_exists(obj_player)) exit;

var dir = sign(x - obj_player.x);

speed_x = Mouse.speed_x + obj_player.speed_x;
speed_y = Mouse.speed_y + obj_player.speed_y;

x += speed_x;
y += speed_y;

// Switch direction
if (abs(x - obj_player.x) < obj_weapon.sprite_width)
{
	x -= 2 * obj_weapon.sprite_width * dir;
}

var cam_x = Camera.x;
var cam_y = Camera.y;
var half_vw = Camera.half_view_width;
var half_vh = Camera.half_view_height;
x = clamp(x, cam_x - half_vw, cam_x + half_vw);
y = clamp(y, cam_y - half_vh, cam_y + half_vh);

direction_x = dir != 0 ? dir : direction_x;