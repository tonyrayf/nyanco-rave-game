if (x > Camera.x + Camera.half_view_width)
or (x < Camera.x - Camera.half_view_width)
or (y > Camera.y + Camera.half_view_height)
or (y < Camera.y - Camera.half_view_height)
{
	instance_destroy();
	exit;
}

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
	var inst = instance_place(x + delta_x, y + delta_y, [obj_block_solid, obj_hitbox, obj_impact_grenade, obj_player]);
	if (inst != noone)
	{
		collision_func(inst, i, sine, cosine);
		
		break;
	}
	++i;
}