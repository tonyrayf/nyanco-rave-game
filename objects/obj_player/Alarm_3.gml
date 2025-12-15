/// @description Slide timer

if (current_state != player_states.slide)
	exit;

audio_play_sound(snd_slide_stop, 100, false);

if (speed_x != 0)
	current_state = !Input.key_run ? player_states.walk : player_states.run;
else
	current_state = player_states.idle;
