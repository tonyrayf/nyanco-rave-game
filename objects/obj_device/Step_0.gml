if (alarm_get(0) == -1 and current_device.current_number > 0)
{	
	current_device.handle_device_interaction();
}