hp = 150;//
my_weapon = variable_clone(Equipment.pistol);//
speed_idle = 2;//speeds in different states
speed_search = 4;//comment means that this variable can be used to configure
speed_detected = 6;//
bot_damage_multiplier = 0.001;//

speed_x = 0;
speed_y = 0;

acceleration_g = 1;

current_spread = 0;
is_damaged = false;
is_reloading = false;
setup = true;
name = "default_name";
suspiciousness = 0;

current_state = states.Idle;//
idle_to_search = 300;//time it takes to go from one state to another
search_to_detected = 180;//
search_to_idle=1800;//

idle_sus_return = 400;//time it takes to suspiciousness to go back
search_sus_return = 600;//

seq = layer_sequence_create(layer, x, y, sq_enemy_regular);
seq_inst = layer_sequence_get_instance(seq);
seq_dir = dirs.Left;