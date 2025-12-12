if (!layer_sequence_exists(layer, seq))
{
	instance_destroy();
	exit;
}

#region X

var step_over = false;  //step over small ledges
if (place_meeting(x + speed_x, y, obj_block_solid)) //Collision check
{
    var i = 1; var step_over_maximum = 10;  //ledge max height to step over
    repeat (step_over_maximum) //Check for small ledge
    {
        if (!place_meeting(x + speed_x, y - i, obj_block_solid))
        {
            y -= i;
            step_over = true;
            break;
        } i += 1;
    }
    if (!step_over) //no need to check for collision if already stepped over the ledge
    {
        while (!place_meeting(x + sign(speed_x), y, obj_block_solid))
        {
            x += sign(speed_x);
        }
        speed_x = 0;
    }
}


x += speed_x;

#endregion
#region Y

speed_y += acceleration_g;

if (place_meeting(x, y + speed_y, obj_block_solid)) //Collision check
{
	while (!place_meeting(x, y + sign(speed_y), obj_block_solid))
	{
		y += sign(speed_y);
	}
	speed_y = 0;
}

y += speed_y;

#endregion

if(setup){
	setup = false;
	
	var head = instance_create_layer(0, 0, layer, obj_hitbox);
	head.hp = hp;
	
	enemy_FOV = get_inst_from_seq(seq, obj_check_hitbox);
	
	with (get_inst_from_seq_by_name(seq, "body"))
	{
		image_alpha = 0;
		hp = hp;
	}
	with (get_inst_from_seq_by_name(seq, "head"))
	{
		image_alpha = 0;
		hp = hp * 0.3;
	}
	with (get_inst_from_seq_by_name(seq, "legs"))
	{
		image_alpha = 0;
		hp = hp * 1.25;
	}
	
	if(name!="default_name" and ds_map_exists(global.paths_map,name)){
		path_start(global.paths_map[?name],speed_idle,path_action_reverse,0);
	}
}

switch current_state{
	case 0:
		if(enemy_FOV.is_object_in_zone){
			suspiciousness++;
			if(suspiciousness>=idle_to_search){
				current_state=states.Search;
				suspiciousness=0;
				alarm[0] = search_to_idle;
				self.path_speed = speed_search;
			}
		} else {
			if(suspiciousness>0){
				suspiciousness-=idle_to_search/idle_sus_return;
			} else if (suspiciousness<0){
				suspiciousness=0;
			}
		}
	break;
	case 1:
		if(enemy_FOV.is_object_in_zone){
			suspiciousness++;
			if(suspiciousness>=search_to_detected){
				suspiciousness=0;
				current_state=states.Detected;
				alarm[0] = -1;
				self.path_speed = speed_detected;
			}
		} else {
			if(suspiciousness>0){
				suspiciousness-=search_to_detected/search_sus_return;
			} else if (suspiciousness<0){
				suspiciousness=0;
			}
		}
	break;
}

layer_sequence_x(seq, x);
layer_sequence_y(seq, y);
