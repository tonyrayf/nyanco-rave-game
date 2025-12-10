if (effective_range != -1)
{
	damage = start_damage * (1 - power(point_distance(xstart, ystart, x, y) / effective_range, 2));
	damage = clamp(damage, 0, start_damage);
	
	// Make bullet more red as damage decrease
	var blend = 255 * damage / start_damage
	image_blend = make_colour_rgb(255, blend, blend);
}

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
		audio_play_sound(snd_hit_marker, 100, false);
		
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
			
			while (place_meeting(x, y, inst))
			{
				x += cosine;
				y += sine;
			}
		}
		
		break;
	}
	++i;
}