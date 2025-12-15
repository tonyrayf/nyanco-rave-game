/// @description Slide timer

if (current_state != player_states.slide)
	exit;

current_state = player_states.walk;
audio_play_sound(snd_slide_stop, 100, false);