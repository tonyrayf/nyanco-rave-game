hp = 100;
speed_idle = 4;
speed_search = 6;
speed_detected = 10;

speed_x = 0;
speed_y = 0;

acceleration_g = 1;

setup = true;
name = "default_name";
enum states {
	Idle,
	Search,
	Detected
}
suspiciousness = 0;

current_state = states.Idle;
idle_to_search = 300;
search_to_detected = 180;
search_to_idle=1800;

idle_sus_return = 400;
search_sus_return = 600;

seq = layer_sequence_create(layer, x, y, sq_enemy_regular);