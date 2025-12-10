start_speed = 0;

damage = 0;
start_damage = 0;

effective_range = -1;

penetrate_probability = 0;
penetrate_decrease_multi = 1;

collision_func = function()
{
	var obj = inst.object_index
	if (obj == obj_block_solid)
	{
		instance_destroy();
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