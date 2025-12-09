if (!active) exit;

next_x = mouse_x - x;
next_y = mouse_y - y;

x += next_x / smooth_multi;
y += next_y / smooth_multi;