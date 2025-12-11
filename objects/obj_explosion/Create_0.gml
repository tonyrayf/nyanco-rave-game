part = part_system_create_layer(layer, false, part_explosion);
part_system_position(part, x, y);

radius = 100;	// in pixels

do_camera_shake(4, 0.5);
audio_play_sound(exp_c4_bang, 100, false, 1);