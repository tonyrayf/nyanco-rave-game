if (place_meeting(x, y + vspeed, global.solid_objects)) 
{
	vspeed /= -2;
}
if (place_meeting(x + hspeed, y, global.solid_objects)) hspeed /= -2;

if (explode)
{
	instance_create_layer(x, y, layer, obj_explosion);
	
	instance_destroy();	exit;
}

image_angle -= speed / 2;