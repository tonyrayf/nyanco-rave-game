
function increase_sus_from_shot(xFrom,yFrom,sound_strength){
	enemies_to_hear = [obj_enemy_regular,obj_enemy_shielded];
	for(var i=0;i<array_length(enemies_to_hear);i++){
		var _instances_count = instance_number(enemies_to_hear[i]);
		for(var j=0;j<_instances_count;j++){
			var _cur_instance = instance_find(enemies_to_hear[i],j);
			var _distance = point_distance(xFrom,yFrom,_cur_instance.x,_cur_instance.y);
			if(variable_instance_exists(_cur_instance, "suspiciousness") and variable_instance_exists(_cur_instance, "current_state") and _cur_instance.current_state!=states.Detected and sound_strength>_distance){
				_cur_instance.suspiciousness+=(sound_strength-_distance);
			}
		}
	}
}