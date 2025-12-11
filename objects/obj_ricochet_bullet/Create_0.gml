event_inherited();

bounces_left = 2;

collision_func = function(inst, i, sine, cosine)
{
	var obj = inst.object_index
	if (obj == obj_block_solid)
	{
		if (bounces_left <= 0)
		{
			instance_destroy();
			return;
		}
		--bounces_left;
		
		var _i = 0;
		while (!place_meeting(x + cosine, y + sine, inst))
		{
			x += cosine;
			y += sine;
			
			if (++_i > i) break;
		}
		
		direction += delta_mirror_direction(direction, inst.image_angle);
		
		image_angle = direction;
		
		audio_play_sound(global.ricco_sounds[irandom(4)], 100, false, 0.3);
	}
	else if (obj == obj_hitbox or object_get_parent(obj) == obj_hitbox)
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
	}
	else if (obj == obj_frag_grenade)
	{
		inst.explode = true;
	}	
}

trail_number = 5;

_x = [];
_y = [];