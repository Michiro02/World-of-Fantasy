audio_stop_all()
audio_play_sound(snd_Sequence,0,false);

sequence_timer = 0; // Timer to track the sequence
show_text = false; // Flag to control when to show the text
fade_out_duration = 60; // Duration of the fade-out effect (in frames)
fade_alpha = 0; // Alpha value for the fade effect
restart_timer = 0; // Timer to restart the game after showing the text