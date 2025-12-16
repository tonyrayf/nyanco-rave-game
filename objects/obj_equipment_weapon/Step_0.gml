if (Input.key_shoot)
{
	if (place_meeting(x, y, obj_equipment_cursor))
	and (obj_equipment_cursor.holding_inst == -1
	or obj_equipment_cursor.holding_inst == id)
	{
		locked = true;
		obj_equipment_cursor.holding_inst = id;
	}
}
else
{
	locked = false;
}

if (locked)
{
	x = obj_equipment_cursor.x - sprite_width / 2;
	y = obj_equipment_cursor.y;
}
else
{
	if (obj_equipment_cursor.holding_inst == id) obj_equipment_cursor.holding_inst = -1
	
	x = lock_x;
	y = lock_y;	
}

if (obj_equipment_cursor.holding_inst != id) locked = false;

var modi = instance_place(x, y, obj_equipment_modification);
if (modi != noone and obj_equipment_cursor.holding_inst != id and lock_y < 374)
{
	with (modi)
	{
		x = lock_x;
		y = lock_y;
	}
	
	switch (modi.sprite_index)
	{
		case spr_suppressor: suppressor = true; break;
		case spr_laser: laser = true; break;
		case spr_ricochet_bullet: ricochet = true; break;
		case spr_extended_mag: extended_mag = true; break;
	}
}