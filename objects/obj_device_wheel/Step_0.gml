// Колесико вверх/вниз — переключаем
var wheel_up = mouse_wheel_up();
var wheel_down = mouse_wheel_down();

if (wheel_up || wheel_down) {
    show_wheel = true;
    wheel_timer = 120;  // 2 сек на 60fps
    
    if (wheel_up) {
        current_index = (current_index + 1) % device_count;  // следующий
    } else {
        current_index = (current_index - 1 + device_count) % device_count;  // предыдущий
    }
    
    current_device = devices[current_index];  // обновляем текущий
}

// Таймер скрытия колеса
if (show_wheel) {
    wheel_timer--;
    if (wheel_timer <= 0) show_wheel = false;
}
