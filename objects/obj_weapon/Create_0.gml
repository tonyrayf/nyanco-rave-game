active = true;

current_weapon = Equipment.auto_rifle;
last_weapon = current_weapon;

current_ammo = 0;
current_spread = 0;
is_reloading = false;

sight_x = 0;
sight_y = 0;

// distance from hand to barrel
barrel_dist = abs(sprite_width - sprite_get_xoffset(sprite_index) * image_xscale);
origin_offset = 30;

draw_setup = true;

ammo_x = 1650;
ammo_y = 900;