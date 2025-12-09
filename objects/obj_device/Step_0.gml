if (setup)
{
	setup = false;
	
	current_device = frag_grenade;	
}

if (last_device != current_device)
{
	last_device = current_device;
	
	current_number = current_device.capacity;
}

if (alarm_get(0) == -1)
{
	current_device.handle_device_interaction();
}