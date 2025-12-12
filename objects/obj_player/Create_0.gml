enum alarms
{
	late_jump,
	early_jump,
}
jump_time = 0.1;

//X
speed_x = 0;

direction_x = 0;
last_direction_x  = 0;

top_speed_x_def = 8;		
top_speed_x_forward = top_speed_x_def;
top_speed_x_back = top_speed_x_def / 1.5;

acceleration_x = 1;
deceleration_x = 1.25;

enum player_states {
	walk,
	crouch,
	run
}
current_state = player_states.walk;

run_multi = 1.35;
crouch_multi = 0.7;


//Y
speed_y = 0;

acceleration_g = 1;

var jump_height = 0.75*sprite_height;
def_jump_start_speed = ceil(sqrt(2 * acceleration_g * jump_height) - 0.5);  //Physics formula: v0 = sqrt(2*g*h)
jump_start_speed = def_jump_start_speed;


//Limits
can_decelerate = true;
can_move = true;
can_jump = true;
can_shoot = true;


// Sound
has_fallen = false;

step_delay = 0.35; // in seconds

start_xscale = image_xscale;
start_yscale = image_yscale;

hp = 100;