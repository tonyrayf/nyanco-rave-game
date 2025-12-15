// Массив девайсов-structs (добавляй новые structs сюда)
devices = [
    { name: "Thermal Goggles", icon: spr_thermal_icon, active: true },  // NVG/тепловизор
    { name: "Impact Grenade", icon: spr_grenade_icon, active: true },    // граната
    // Добавь новые: { name: "Flashbang", icon: spr_flash_icon, active: true }
];

current_index = 0;  // текущий девайс
current_device = devices[0];  // ссылка на struct

device_count = array_length(devices);
wheel_radius = 80;  // радиус колеса
wheel_center_x = display_get_gui_width() / 2;
wheel_center_y = display_get_gui_height() * 0.7;  // снизу экрана
show_wheel = true;  // показывать колесо?
wheel_timer = 0;     // таймер скрытия