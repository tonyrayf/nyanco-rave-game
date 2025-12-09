/// @param {real}      to_width		  Конечная длина
/// @param {real}      zoom_duration  Продолжительность (в секундах)
/// @param {function}  easing		  Функция плавности
/// @description					  Функция зума вида камеры

function do_camera_zoom
(
	to_width,
	zoom_duration = 1,
	easing = function(_x) { return _x; }
)
{
	with (Camera)
	{
		zoom_active = true;
		
		start_view_width = half_view_width * 2;
		final_view_width = to_width;
		
		start_offset_x = offset_x;
		start_offset_y = offset_y;
		
		iterator = 0;
		zoom_time = zoom_duration;
		delta_i = 1 / (zoom_time * game_get_speed(gamespeed_fps));
		
		easing_func = easing;
	}
}

function do_camera_shake(amplitude, duration)
{	
	with (Camera)
	{
		shake_active = true;
		shake_amplitude = amplitude;
		shake_duration = duration;
		
		alarm_set(0, duration * game_get_speed(gamespeed_fps));
	}
}