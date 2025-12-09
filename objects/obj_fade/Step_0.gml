if (setup)
{
	setup = false;
	delta_i = 1 / (fade_time * game_get_speed(gamespeed_fps));
}


x = camera_get_view_x(view_camera[0]);
y = camera_get_view_y(view_camera[0]);


iterator -= delta_i;

image_alpha = lerp(0, 1, easing_func(iterator));


if (iterator <= 0)
{
	iterator = 0;
	delta_i = -delta_i;
	
	image_alpha = 0;
	
	if (!destroy)	instance_deactivate_object(self);
	else			instance_destroy();
}
else if (iterator >= 1)
{
	room_goto(to_room);
}