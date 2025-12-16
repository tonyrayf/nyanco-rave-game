x += Mouse.speed_x;
y += Mouse.speed_y;

x = clamp(x, 0, room_width);
y = clamp(y, 0, room_height);