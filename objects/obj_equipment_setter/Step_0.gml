if (place_meeting(x, y, obj_equipment_cursor) and Input.key_shoot_press)
{
	obj_weapon.first_weapon = variable_clone(weapon);
	audio_play_sound(weapon.reload_sound, 100, false, 0.2);
}