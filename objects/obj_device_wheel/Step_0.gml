if (Input.key_device_wheel)
{
    show_wheel = true;
	
	if (Mouse.speed_y != 0 or Mouse.speed_x != 0)
	{
		distance += sqrt(Mouse.speed_x*Mouse.speed_x + Mouse.speed_y*Mouse.speed_y);
		
		if (distance >= distance_to_change)
		{
			distance = 0;
			
			var angle = radtodeg(arctan2(-Mouse.speed_y, Mouse.speed_x));
			if (angle < 0) angle += 360;
			current_index = clamp(floor(angle / 360 * device_count), 0, device_count - 1);
			
			current_device = devices[current_index];
		}
	}
}
else if (Input.key_device_wheel_release)
{
	obj_device.current_device = variable_clone(current_device.device);
}
else
{
	show_wheel = false;
}