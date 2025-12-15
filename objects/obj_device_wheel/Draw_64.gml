if (show_wheel) {
    // Фон колеса (полупрозрачный круг)
    draw_set_color(c_black);
    draw_set_alpha(0.7);
    draw_circle(wheel_center_x, wheel_center_y, wheel_radius + 10, false);
    draw_set_alpha(1);
    
    // Иконки девайсов по кругу
    var angle_step = 360 / device_count;
    for (var i = 0; i < device_count; i++) {
        var dev = devices[i];
        var angle = (current_index - i) * angle_step;  // текущий в центре
        var dev_x = wheel_center_x + lengthdir_x(wheel_radius, angle);
        var dev_y = wheel_center_y + lengthdir_y(wheel_radius, angle);
        
        // Выделяем текущий
        var scale = (i == current_index) ? 1.2 : 1.0;
        draw_sprite_ext(dev.icon, 0, dev_x, dev_y, scale, scale, 0, c_white, 1);
        
        // Тень для 3D
        draw_sprite_ext(dev.icon, 0, dev_x + 2, dev_y + 2, scale * 0.8, scale * 0.8, 0, c_black, 0.4);
    }
    
    // Центральный индикатор (текущий девайс)
    draw_sprite_ext(current_device.icon, 0, wheel_center_x, wheel_center_y, 1.5, 1.5, 0, c_white, 1);
    
    draw_set_color(c_white);
}

// Текущий девайс всегда виден (маленькая иконка в углу)
draw_sprite_ext(current_device.icon, 0, 20, display_get_gui_height() - 60, 0.8, 0.8, 0, c_white, 1);