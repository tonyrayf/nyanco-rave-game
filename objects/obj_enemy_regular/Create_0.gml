hp = 100;//
my_weapon = variable_clone(Equipment.smg);//
speed_idle = 2;//speeds in different states
speed_search = 4;//comment means that this variable can be used to configure
speed_detected = 6;//
bot_damage_multiplier = 0.3;//

speed_x = 0;
speed_y = 0;

acceleration_g = 1;

current_spread = 0;
is_damaged = false;
is_reloading = false;
setup = true;
name = "default_name";
suspiciousness = 0;

last_state = states.Idle;
current_state = states.Idle;//
idle_to_search = 300;//time it takes to go from one state to another
search_to_detected = 230;//
search_to_idle=1800;//

reaction_time = 0.3;

idle_sus_return = 400;//time it takes to suspiciousness to go back
search_sus_return = 600;//

seq = layer_sequence_create(layer, x, y, sq_enemy_regular);
seq_inst = layer_sequence_get_instance(seq);
seq_dir = dirs.Left;

layer_sequence_xscale(seq, image_xscale);