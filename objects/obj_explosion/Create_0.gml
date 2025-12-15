part = part_system_create_layer(layer, false, part_explosion);
part_system_position(part, x, y);
part_system_angle(part, image_angle);

damage = 200;
radius = 400;	// in pixels

image_xscale *= radius;
image_yscale *= radius;


do_camera_shake(4, 0.5);
audio_play_sound(exp_c4_bang, 100, false, 1);


var insts = ds_list_create();
instance_place_list(x, y, [obj_player, obj_hitbox, obj_enemy], insts, false);

var i = 0;
repeat (ds_list_size(insts))
{
	var inst = insts[| i++];
	if (inst.object_index != obj_enemy)
	{
		var dist = point_distance(x, y, inst.x, inst.y);
	
		if (dist >= radius) inst.hp -= damage;
		else inst.hp -= ceil(damage * (1 - dist / radius) - 0.5);
	}
	else
	{
		inst.current_state = states.Detected;
	}
}