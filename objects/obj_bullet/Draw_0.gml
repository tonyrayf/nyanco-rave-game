draw_self();

// Draw bullet trails
var i = 1;
repeat (floor(speed))
{
	var dir = degtorad(direction);
	var _x = x - sprite_width * cos(dir) * i;
	var _y = y + sprite_width * sin(dir) * i;
	
	if (sign(hspeed) == sign(_x - xstart) and sign(vspeed) == sign(_y - ystart))
		draw_sprite_ext(spr_bullet_trail, 0, _x, _y, 1, 1, image_angle, image_blend, 0.5 * (1 - i / floor(speed)));
	i += 1;
}

//draw_circle(x + speed* cos(degtorad(direction)), y - speed * sin(degtorad(direction)), 10, false);