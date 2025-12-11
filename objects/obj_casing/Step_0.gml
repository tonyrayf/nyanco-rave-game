if (fade_away)
{
	image_alpha -= 0.02;
	
	if (image_alpha < 0) instance_destroy();
}

if (place_meeting(x + speed_x, y, global.solid_objects))
{
	while (!place_meeting(x + sign(speed_x), y, global.solid_objects)) x += sign(speed_x);
	speed_x = 0;
}

x += speed_x;

speed_y += acceleration_g;

if (place_meeting(x, y + speed_y, global.solid_objects))
{
	if (!fallen)
	{
		fallen = true;
		audio_play_sound([snd_casing_eject_1, snd_casing_eject_2, snd_casing_eject_3, snd_casing_eject_4, snd_casing_eject_5][irandom(4)], 100, false, 0.1);
	}
	
	while (!place_meeting(x, y + sign(speed_y), global.solid_objects)) y += sign(speed_y);
	speed_y = 0;
	speed_x = 0;
}

y += speed_y;