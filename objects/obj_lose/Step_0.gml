image_alpha += 0.01;

if (image_alpha > 2 and Input.key_shoot) with (instance_create_depth(0, 0, -20, obj_fade))
{
	to_room = room;
	image_alpha = 0;
	fade_time = -1;
	iterator = 0;
}