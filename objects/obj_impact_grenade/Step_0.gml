if (place_meeting(x + hspeed, y, global.solid_objects)) 
{
	explode = true;
	explosion_angle = sign(hspeed) * 90;
}
else if (place_meeting(x, y + vspeed, global.solid_objects))
{
	explode = true;
	explosion_angle = sign(vspeed) == DOWN ? 0 : 180;
}

if (explode)
{
	instance_create_layer(x, y, layer, obj_explosion, {image_angle :  explosion_angle});
	
	instance_destroy();	exit;
}

image_angle -= speed / 2;