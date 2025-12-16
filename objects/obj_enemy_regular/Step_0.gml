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
		maxhp = hp;
	}
	with (get_inst_from_seq_by_name(seq, "head"))
	{
		image_alpha = 0;
		hp = parent_hp * 0.3;
		maxhp = hp;
	}
	with (get_inst_from_seq_by_name(seq, "legs"))
	{
		image_alpha = 0;
		hp = parent_hp * 1.25;
		maxhp = hp;
	}
	
	if(name!="default_name" and ds_map_exists(global.paths_map,name)){
		path_start(global.paths_map[?name],speed_idle,path_action_reverse,0);
	}
	
	if(seq_dir==dirs.Left){
		direction = 180;
	}
}

if(current_state!=states.Detected and seq_inst!=undefined and seq_inst.is_damaged){
	suspiciousness=0;
	current_state=states.Detected;
	alarm[0] = -1;
	self.path_speed = speed_detected;
}

switch current_state{
	case states.Idle:
		if(enemy_FOV.is_object_in_zone){
			if(self.path_speed!=0){
				self.path_speed=path_speed=0;
			}
			suspiciousness+=1000/point_distance(x,y,obj_player.x,obj_player.y);
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
		if(suspiciousness>=idle_to_search){
			current_state=states.Search;
			suspiciousness=0;
			alarm[0] = search_to_idle;
			self.path_speed = speed_search;
		}
	break;
	case states.Search:
		if(enemy_FOV.is_object_in_zone){
			suspiciousness+=1000/point_distance(x,y,obj_player.x,obj_player.y);
		} else {
			if(suspiciousness>0){
				suspiciousness-=search_to_detected/search_sus_return;
			} else if (suspiciousness<0){
				suspiciousness=0;
			}
		}
		if(suspiciousness>=search_to_detected){
			suspiciousness=0;
			current_state=states.Detected;
			alarm[0] = -1;
			self.path_speed = speed_detected;
		}
	break;
	case states.Detected:
		if(enemy_FOV.is_object_in_zone){
			if(self.path_speed!=0){
				self.path_speed=0;
			}
			if (alarm_get(1)==-1 and my_weapon.current_ammo > 0 and not is_reloading){
				increase_sus_from_shot(x,y,800);
				alarm_set(1,game_get_speed(gamespeed_fps)/my_weapon.fire_rate*60);
				var _s = self;
				repeat(my_weapon.shells_in_shot){
					with (instance_create_layer(x-50*image_xscale, y-100, obj_player.layer, obj_bullet)){
						var spread_dir = arctan(_s.current_spread / _s.my_weapon.range) * DEG_PER_RAD;
						if(_s.image_xscale==1){
							direction = random_range(180-spread_dir,180+spread_dir);
						} else if (_s.image_xscale==-1){
							direction = random_range( - spread_dir,spread_dir);
						}
						
						var vel = _s.my_weapon.velocity;
						var vel_spread = _s.my_weapon.velocity_spread / 100;
						start_speed = random_range(vel * (1 - vel_spread), vel * (1 + vel_spread));
						speed = start_speed;
						
						image_angle = direction;
						sprite_index = _s.my_weapon.shell_sprite;
						
						start_damage = _s.my_weapon.damage*_s.bot_damage_multiplier;
						damage = start_damage;
					}
				}
				my_weapon.current_ammo -= 1;
				current_spread += my_weapon.spread_jump;
				
				do_camera_shake(my_weapon.shake_amplitude, 0.3);
		
				var snd = my_weapon.shot_sound;
				audio_play_sound(snd.sound, 100, false, snd.gain, 0, snd.pitch);
				audio_play_sound(snd_weap, 100, false, 0.5);
			} else if (alarm_get(1)==-1 and my_weapon.current_ammo <= 0 and not is_reloading) {
				is_reloading = true;
				alarm_set(2, my_weapon.reload_time * game_get_speed(gamespeed_fps));
				if (variable_struct_exists(my_weapon, "reload_sound")) audio_play_sound(my_weapon.reload_sound, 100, false, 0.2);
			}
		} else {
			if(self.path_speed==0){
				self.path_speed=speed_detected;
			}
			if(not is_reloading and my_weapon.current_ammo<my_weapon.capacity*1){
				is_reloading = true;
				alarm_set(2, my_weapon.reload_time * game_get_speed(gamespeed_fps));
				if (variable_struct_exists(my_weapon, "reload_sound")) audio_play_sound(my_weapon.reload_sound, 100, false, 0.2);
			}
		}
	break;
}

layer_sequence_x(seq, x);
layer_sequence_y(seq, y);

if(enemy_FOV.is_object_in_zone){
	if((x-obj_player.x)>0){
		layer_sequence_xscale(seq,1);
		image_xscale = 1;
	} else {
		layer_sequence_xscale(seq,-1);
		image_xscale = -1;
	}
} else if(direction==180 and seq_dir==dirs.Right){
	layer_sequence_xscale(seq,1);
	image_xscale = 1;
	seq_dir=dirs.Left;
} else if(direction==0 and seq_dir==dirs.Left){
	layer_sequence_xscale(seq,-1);
	image_xscale = -1;
	seq_dir=dirs.Right;
}