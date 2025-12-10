part = part_system_create_layer(layer, false, part_explosion);
part_system_position(part, x, y);

radius = 100;	// in pixels

do_camera_shake(4, 0.5);
audio_play_sound(snd_shotgun, 100, false, 2, 0, 0.8);