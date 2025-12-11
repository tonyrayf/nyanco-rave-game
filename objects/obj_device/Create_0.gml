setup = true;

current_device = {};
last_device = {};

current_number = 0;

impact_grenade = {
	// Общие параметры
	cooldown : 3,    // в секундах
    capacity : 4,
	
	// Так как девайсы очень разные по применению и функционалу
	// у каждого полностью своя функция применения
    handle_device_interaction : function()
    {
		// Вычисление траектории
        if (Input.key_device)
        {
            weapon_set_active(false);
			
			if (trajectory_inst == noone)
			{
				trajectory_inst = instance_create_layer(0, 0, obj_player.layer, obj_throw_devices_trajectory);
				trajectory_inst.throw_speed = throw_speed;
				trajectory_inst.throw_gravity = throw_gravity;
			}
			
			throw_direction = trajectory_inst.throw_direction;
		}
		// Бросание гранаты
        if (Input.key_device_release)
        {
			var cldwn = cooldown;
			with (obj_device)
			{
				alarm_set(0, cldwn * game_get_speed(gamespeed_fps));
				current_number -= 1;
			}
			
            weapon_set_active(true);
			
			obj_shoot_area.x = trajectory_inst.x;
			obj_shoot_area.y = trajectory_inst.y;
			
			instance_destroy(trajectory_inst);
			trajectory_inst = noone;
			
			var _s = self;
			with (instance_create_layer(obj_player.x, obj_player.y - 20, obj_player.layer, grenade))
			{
				direction = _s.throw_direction;
				speed = _s.throw_speed;
				gravity = _s.throw_gravity;
			}
        }
    },
	
	// Индивидуальные параметры
	trajectory_inst : noone,
	throw_speed : 22.5,
	throw_gravity : 0.5,
	throw_direction : 0,
	grenade : obj_impact_grenade
}