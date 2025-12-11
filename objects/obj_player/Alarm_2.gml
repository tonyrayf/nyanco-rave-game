/// @description Footstep timer

var i = irandom(4);

switch (current_state)
{
	case player_states.walk: audio_play_sound(global.walk_sounds[i], 100, false); break;
	case player_states.crouch: audio_play_sound(global.walk_sounds[i], 100, false, 0.5); break;
	case player_states.run: audio_play_sound(global.run_sounds[i], 100, false);
}