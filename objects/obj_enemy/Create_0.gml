hp = 100;

speed_x = 0;
speed_y = 0;

acceleration_g = 1;

seq = layer_sequence_create(layer, x, y, sq_enemy_regular);
function get_from_seq(seq,obj_name){
	seq_objects = sequence_get_objects(layer_sequence_get_sequence(seq));
	for(var i = 0; i<array_length(seq_objects); i++){
		if(object_get_name(seq_objects[i])==obj_name){
			return seq_objects[i];
		}
	}
}
enemy_FOV = get_from_seq(seq,"obj_check_hitbox");
