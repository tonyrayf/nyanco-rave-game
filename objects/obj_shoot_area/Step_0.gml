if (!active) exit;

next_x = Mouse.x - x;
next_y = Mouse.y - y;

x += next_x / smooth_multi;
y += next_y / smooth_multi;