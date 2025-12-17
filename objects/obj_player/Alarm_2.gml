/// @description Footstep timer

var i = irandom(4);

switch (current_state)
{
	case player_states.walk: {
		audio_play_sound(global.walk_sounds[i], 100, false);
		
		increase_sus_from_shot(x, y, 80, 1500);
		break;
	}
	case player_states.crouch: {
		audio_play_sound(global.walk_sounds[i], 100, false, 0.5);
		break;
	}
	case player_states.run: {
		audio_play_sound(global.run_sounds[i], 100, false);
		
		increase_sus_from_shot(x, y, 120, 1500);
		break;
	}
}