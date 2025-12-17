if (show_wheel)
{	
	draw_set_alpha(0.3);
    draw_circle_colour(circle_x, circle_y, wheel_radius + 10, c_aqua, c_blue, false);
	draw_set_alpha(1);
    
    var angle_step = 360 / device_count;
	var phase = 180 / device_count;
	
	var i = 0;
    repeat (device_count)
	{
        var dev = devices[i];
        var angle = i * angle_step + phase;
        var dev_x = circle_x + lengthdir_x(wheel_radius, angle);
        var dev_y = circle_y + lengthdir_y(wheel_radius, angle);
        
        var scale = 120 / sprite_get_width(dev.icon) * (current_index == i ? 1.1 : 1);
        draw_sprite_ext(dev.icon, 0, dev_x, dev_y, scale, scale, 0, c_white, 1);
		++i;
    }
}