if (setup)
{
	setup = false;
	
	current_device = impact_grenade;	
}

if (last_device != current_device)
{
	last_device = current_device;
	
	current_number = current_device.capacity;
}

if (alarm_get(0) == -1 and current_number > 0)
{
	current_device.handle_device_interaction();
}