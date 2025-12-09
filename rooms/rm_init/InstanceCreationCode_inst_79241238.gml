alarm_set(0, 1 * game_get_speed(gamespeed_fps));

alarm0_func = function()
{
	room_goto_next();
}