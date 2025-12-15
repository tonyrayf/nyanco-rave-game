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

if (setup)
{
	setup = false;
	
	enemy_FOV = get_inst_from_seq(seq, obj_check_hitbox);
	
	var parent_hp = hp;
	with (get_inst_from_seq_by_name(seq, "body"))
	{
		image_alpha = 0;
		hp = parent_hp;
	}
	with (get_inst_from_seq_by_name(seq, "head"))
	{
		image_alpha = 0;
		hp = parent_hp * 0.3;
	}
	with (get_inst_from_seq_by_name(seq, "legs"))
	{
		image_alpha = 0;
		hp = parent_hp * 1.25;
	}
	
	if(name!="default_name" and ds_map_exists(global.paths_map,name)){
		path_start(global.paths_map[?name],speed_idle,path_action_reverse,0);
	}
	
	if(direction==180){
		seq_dir = dirs.Left;
	} else if(direction==0){
		seq_dir = dirs.Right;
		layer_sequence_xscale(seq,-1);
		image_xscale=-1;
	}
	
}

switch current_state{
	case states.Idle:
		if(enemy_FOV.is_object_in_zone){
			show_debug_message(name+" "+string(point_distance(x,y,obj_player.x,obj_player.y)));
			suspiciousness+=1000/point_distance(x,y,obj_player.x,obj_player.y);
			if(self.path_speed!=0){
				self.path_speed=0;
			}
			if(suspiciousness>=idle_to_search){
				current_state=states.Search;
				suspiciousness=0;
				alarm[0] = search_to_idle;
				self.path_speed = speed_search;
			}
		} else {
			if(self.path_speed==0){
				self.path_speed=speed_idle;
			}
			if(suspiciousness>0){
				suspiciousness-=idle_to_search/idle_sus_return;
			} else if (suspiciousness<0){
				suspiciousness=0;
			}
		}
	break;
	case states.Search:
		if(enemy_FOV.is_object_in_zone){
			suspiciousness+=1000/point_distance(x,y,obj_player.x,obj_player.y);
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

if(direction==180 and seq_dir==dirs.Right){
	layer_sequence_xscale(seq,1);
	image_xscale = 1;
	seq_dir=dirs.Left;
} else if(direction==0 and seq_dir==dirs.Left){
	layer_sequence_xscale(seq,-1);
	image_xscale = -1;
	seq_dir=dirs.Right;
}
