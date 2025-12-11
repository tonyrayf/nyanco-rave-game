if (place_meeting(x + hspeed, y + vspeed, global.solid_objects)) 
{
	explode = true;
}

if (explode)
{
	instance_create_layer(x, y, layer, obj_explosion);
	
	instance_destroy();	exit;
}

image_angle -= speed / 2;