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

if (obj_equipment_cursor.holding_inst != id) locked = false;

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