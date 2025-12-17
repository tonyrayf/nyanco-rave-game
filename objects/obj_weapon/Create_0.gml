active = true;

dir_cos = 0;
dir_sin = 0;

first_weapon = variable_clone(Equipment.assault_rifle); first_w_mods = [];
second_weapon = variable_clone(Equipment.pistol); second_w_mods = [];

current_weapon = first_weapon;
last_weapon = {};

current_mods = first_w_mods;

mods_setup = true;

current_spread = 0;
is_reloading = false;

sight_x = 0;
sight_y = 0;

// distance from hand to barrel
barrel_dist = abs(sprite_width - sprite_get_xoffset(sprite_index) * image_xscale);
origin_offset = 60;

draw_setup = true;

ammo_x = 1650;
ammo_y = 900;