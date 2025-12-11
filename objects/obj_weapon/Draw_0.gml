if (!active or !instance_exists(obj_player)) exit;

draw_self();

var i = 0;
repeat (array_length(current_mods))
{
	current_mods[i++].draw_func();
}