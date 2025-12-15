hp = 150;
speed_idle = 2;
speed_search = 4;
speed_detected = 6;

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
enum dirs {
	Left,
	Right
}
seq_dir = dirs.Right;