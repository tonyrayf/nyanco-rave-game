change_weapon = function()
{
	obj_weapon.second_w_mods = [];
	
	switch (current_w.sprite_index)
	{
		case spr_kilo_right:	obj_weapon.second_weapon = variable_clone(Equipment.assault_rifle); break;
		case spr_spr_right:		obj_weapon.second_weapon = variable_clone(Equipment.sniper_rifle); break;
		case spr_iso_right:		obj_weapon.second_weapon = variable_clone(Equipment.smg); break;
		case spr_shotgun_right: obj_weapon.second_weapon = variable_clone(Equipment.shotgun); break;
		case spr_pistol_right:	obj_weapon.second_weapon = variable_clone(Equipment.pistol); break;
	}
}