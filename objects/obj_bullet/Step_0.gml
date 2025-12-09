var i = 0;
repeat (speed)
{
	var inst = instance_place(x + i * cos(degtorad(direction)), y - i * sin(degtorad(direction)), obj_hitbox)
	if (inst != noone)
	{
		audio_play_sound(inst.hp > damage ? snd_hit_marker : snd_hit_marker_kill, 100, false);
		
		inst.hp -= damage;
		instance_destroy();
	}
	++i;
}