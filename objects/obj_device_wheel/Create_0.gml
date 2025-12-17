devices = [
    { name: "Thermal Goggles", icon: spr_thermal_goggles, device : Equipment.thermal_googles },
    { name: "Impact Grenade", icon: spr_impact_grenade, device : Equipment.impact_grenade },
];

current_index = 0;
current_device = devices[0];

device_count = array_length(devices);
wheel_radius = 180;
show_wheel = false;

distance = 0;
distance_to_change = 35;

circle_x = Camera.half_view_width;
circle_y = Camera.half_view_height - 200;