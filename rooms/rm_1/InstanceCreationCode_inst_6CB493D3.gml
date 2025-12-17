hp = 60;

sprite = layer_sprite_get_id("Assets", "graphic_50B5FD14");
step_func = function()
{
	var inst = instance_place(x, y, obj_bullet);
	if (inst != noone)
	{
		hp -= inst.damage;
	}
	
	if (hp < 0)
	{
		layer_sprite_destroy(sprite);
		instance_destroy(inst_48DD2763);
		instance_destroy();
	}
}