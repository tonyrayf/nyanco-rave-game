/// @description Check buttons

if (keyboard_check_pressed(keyboard_key))
{
	switch (keyboard_key)
	{
		case vk_numpad1: if (room != room_first) room_goto_previous(); break;
		case vk_numpad2: if (room != room_last) room_goto_next(); break;
		case vk_f4: window_set_fullscreen(!window_get_fullscreen()); break;
		case vk_f2: audio_group_set_gain(audiogroup_sound, !audio_group_get_gain(audiogroup_sound))
	}
	
	if (instance_exists(obj_weapon)) with (obj_weapon) switch (keyboard_key)
	{
		case ord("1"): current_weapon = auto_rifle; break;
		case ord("2"): current_weapon = smg; break;
		case ord("3"): current_weapon = sniper_rifle; break;
		case ord("4"): current_weapon = pistol; break;
		case ord("5"): current_weapon = shotgun; break;
		case ord("6"): current_weapon = auto_shotgun; break;
		case ord("0"): current_weapon = admin_gun; break;
		case ord("9"): current_weapon = admin_gun2; break;
	}
}