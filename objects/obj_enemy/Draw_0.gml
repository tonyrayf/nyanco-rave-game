draw_self();

yOffset = 250;
switch current_state{
	case 0:
		if(suspiciousness>0){
			draw_sprite(spr_idle,-1,x,y-yOffset);
		}
	break;
	case 1:
		draw_sprite(spr_search,-1,x,y-yOffset);
	break;
	case 2:
		draw_sprite(spr_detected,-1,x,y-yOffset);
	break;
}