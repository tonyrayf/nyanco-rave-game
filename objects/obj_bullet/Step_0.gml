var i = 0;
repeat (speed)
{
	var cosine = cos(degtorad(direction));
	var sine = -sin(degtorad(direction));
	var delta_x = i * cosine;
	var delta_y = i * sine;
	var inst = instance_place(x + delta_x, y + delta_y, obj_hitbox)
	if (inst != noone)
	{
		audio_play_sound(inst.hp > damage ? snd_hit_marker : snd_hit_marker_kill, 100, false);
		
		inst.hp -= damage;
		if (penetrate_probability == 0 or random(1) > penetrate_probability / 100)
		{
			instance_destroy();
		}
		else
		{
			penetrate_probability /= penetrate_decrease_multi;
			
			// We need to be sure that bullet truly passes through,
			// So there won't be mulitple collisions in one hit
			x += hspeed;
			y += vspeed;
			
			while (place_meeting(x, y, obj_hitbox))
			{
				x += cosine;
				y += sine;
			}
		}
		
		break;
	}
	++i;
}