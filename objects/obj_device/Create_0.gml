setup = true;

current_device = {};
last_device = {};

current_number = 1;

frag_grenade = {
    handle_device_interaction : function()
    {
        if (Input.key_device)
        {
            weapon_set_active(false);
			
			if (trajectory_inst == noone)
			{
				trajectory_inst = instance_create_layer(obj_player.x, obj_player.y, obj_player.layer, obj_throw_devices_trajectory);
				trajectory_inst.throw_speed = throw_speed;
				trajectory_inst.throw_gravity = throw_gravity;
			}
			
			throw_direction = trajectory_inst.throw_direction;
		}
        if (Input.key_device_release)
        {
            alarm_set(0, cooldown * game_get_speed(gamespeed_fps));

            weapon_set_active(true);
			
			var _s = self;
			with (instance_create_layer(obj_player.x, obj_player.y - 20, obj_player.layer, obj_frag_grenade))
			{
				direction = _s.throw_direction;
				speed = _s.throw_speed;
				gravity = _s.throw_gravity;
			}
			
			instance_destroy(trajectory_inst);
			trajectory_inst = noone;
        }
    },
    cooldown : 1,    // in seconds
    capacity : 4,
	trajectory_inst : noone,
	throw_speed : 25,
	throw_gravity : 0.5,
	throw_direction : 0,
}