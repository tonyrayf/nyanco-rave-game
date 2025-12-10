draw_self();

var _sus_percent;
yOffset = 250;
switch current_state{
	case 0:
		if(suspiciousness>0){
			draw_sprite(spr_idle,-1,x,y-yOffset-15);
			_sus_percent = suspiciousness/idle_to_search;
		}
	break;
	case 1:
		draw_sprite(spr_search,-1,x,y-yOffset-15);
		_sus_percent = suspiciousness/search_to_detected;
	break;
	case 2:
		draw_sprite(spr_detected,-1,x,y-yOffset-15);
	break;
}

if(suspiciousness>0){
	draw_sprite(spr_stealth_bar,-1,x,y-yOffset);
	draw_sprite_part(spr_stealth_bar_fill,-1,0,0,sprite_get_width(spr_stealth_bar_fill)*_sus_percent,sprite_get_height(spr_stealth_bar_fill),x-46,y-yOffset-10);
}