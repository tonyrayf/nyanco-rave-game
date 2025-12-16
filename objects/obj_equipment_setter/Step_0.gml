var insts = ds_list_create();
instance_place_list(x, y, obj_equipment_weapon, insts, false);
	
var i = 0;
repeat (ds_list_size(insts))
{
	var inst = insts[| i++];
	if (inst == current_w)
	{
		if (x < room_width / 2)
		{
			if (inst.suppressor and !array_contains(obj_weapon.first_w_mods, Equipment.suppressor)) array_push(obj_weapon.first_w_mods, Equipment.suppressor);
			if (inst.extended_mag and !array_contains(obj_weapon.first_w_mods, Equipment.extended_mag)) array_push(obj_weapon.first_w_mods, Equipment.extended_mag);
			if (inst.laser and !array_contains(obj_weapon.first_w_mods, Equipment.laser)) array_push(obj_weapon.first_w_mods, Equipment.laser);
			if (inst.ricochet and !array_contains(obj_weapon.first_w_mods, Equipment.ricochet_ammo)) array_push(obj_weapon.first_w_mods, Equipment.ricochet_ammo);
		}
		else
		{
			if (inst.suppressor and !array_contains(obj_weapon.second_w_mods, Equipment.suppressor)) array_push(obj_weapon.second_w_mods, Equipment.suppressor);
			if (inst.extended_mag and !array_contains(obj_weapon.second_w_mods, Equipment.extended_mag)) array_push(obj_weapon.second_w_mods, Equipment.extended_mag);
			if (inst.laser and !array_contains(obj_weapon.second_w_mods, Equipment.laser)) array_push(obj_weapon.second_w_mods, Equipment.laser);
			if (inst.ricochet and !array_contains(obj_weapon.second_w_mods, Equipment.ricochet_ammo)) array_push(obj_weapon.second_w_mods, Equipment.ricochet_ammo);
		}
		
		continue;
	}
		
	if (inst != noone and current_w != inst)
	{
		with (current_w)
		{
			lock_x = xstart;
			lock_y = ystart;
		}
		
		current_w = inst;
		
		inst.lock_x = x - inst.sprite_width / 2;
		inst.lock_y = y - sprite_get_yoffset(inst.sprite_index);
	
		change_weapon();
		
		with (obj_weapon)
		{
			current_weapon = first_weapon;
		}
	}
}