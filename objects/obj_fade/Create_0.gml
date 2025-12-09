x = camera_get_view_x(view_camera[0]);
y = camera_get_view_y(view_camera[0]);

sprite_set_color(c_black);

image_xscale = camera_get_view_width  (view_camera[0]);
image_yscale = camera_get_view_height (view_camera[0]);

image_alpha = 1;


iterator = 1;
fade_time = 1;  //time (in seconds)
delta_i = 0;

easing_func = function(_x) { return _x; };


to_room = room_next(room);

destroy = false;

setup = true;