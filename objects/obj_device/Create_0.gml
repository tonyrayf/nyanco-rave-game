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
        }
        if (Input.key_device_release)
        {
            alarm_set(0, cooldown * game_get_speed(gamespeed_fps));

            weapon_set_active(true);
        }
    },
    cooldown : 1,    // in seconds
    capacity : 4,
}