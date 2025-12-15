follow_player = true;

half_view_width	 = camera_get_view_width (view_camera[0]) / 2;
half_view_height = camera_get_view_height(view_camera[0]) / 2;

camera_speed_x = 0;
camera_speed_y = 0;
cam_smooth_multi = 15;  //smooth multiplier


offset_x = 300;
offset_y = -340;

if (instance_exists(obj_player))
{
	x = obj_player.x + offset_x;
	y = obj_player.y + offset_y;
	
	x = clamp(x, half_view_width,  room_width  - half_view_width);
	y = clamp(y, half_view_height, room_height - half_view_height);
}


next_x = x;
next_y = y;

#region Zoom

zoom_active = false;

start_view_width = half_view_width * 2;
final_view_width = 0;

start_offset_x = offset_x;
start_offset_y = offset_y;

iterator = 0;
zoom_time = 1;  //time (in seconds)
delta_i = 1 / (zoom_time * game_get_speed(gamespeed_fps));

easing_func = function(_x) { return _x; }

#endregion

#region Shake

shake_active = false;
shake_amplitude = 0;
shake_duration = 0;

#endregion