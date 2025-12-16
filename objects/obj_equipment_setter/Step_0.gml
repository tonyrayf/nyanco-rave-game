if (Input.key_shoot and place_meeting(x, y, obj_equipment_cursor))
	image_alpha += 0.02;
else
	image_alpha -= 0.02;

image_alpha = max(image_alpha, 0);

if (image_alpha > 0.6)
{
	instance_destroy();
	audio_play_sound(weapon.reload_sound, 100, false, 0.2);
	
	if (layer_text_get_alpha(text1) == 1)
	{
		obj_weapon.first_weapon = variable_clone(weapon);
	
		layer_text_alpha(text1, 0);
		layer_text_alpha(text2, 1);
	}
	else
	{
		obj_weapon.second_weapon = variable_clone(weapon);
		
		layer_text_alpha(text2, 0);
		
		layer_destroy("Text");
		layer_destroy("Weapons");
	}
}