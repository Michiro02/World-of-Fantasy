audio_stop_all();
audio_play_sound(snd_Ending_1,1,true);

credits_text = "With the Warring Triad finally vanquished, the\nvery foundation of the world trembles-not in\nfear, but in renewal. The deities' fading power\nleaves behind a world no longer bound by the\nwhims of ancient forces.\n\nFor the first time in history, the people stand\nfree, shaping their own destiny without gods\nor war. The five adventurers, weary but proud,\nwitness the dawn of an era of true peace.\n\nThe scars of battle remain, yet they are now\nreminders of courage, sacrifice, and the hope\nthat guided them through even the darkest\nnights. The echoes of their struggle will\nresonate through history, told in songs and\nlegends for generations to come.\n\nAs they look upon the world they have saved,\na quiet understanding passes between them.\nTheir journey has ended, yet the bonds they\nforged will never fade. Wherever fate may\nlead them, they walk forward, not as warriors\nof war, but as champions of a new tomorrow.\n\nAnd at last, the world breathes in peace.\n\n" +
               "\n\nSpecial thanks to\n\n-Valerie Silverio\n" +
			   "\n\nGame Designer\n\n-Milan Mababangloob Jr.\n-Jobelle Villanueva\n" +
               "\n\nProgrammers\n\n-Milan Mababangloob Jr.\n-Jobelle Villanueva\n" +
               "\n\nBackground Music\n\n-Milan Mababangloob Jr.\n" +
			   "\n\nSound Effects\n\n-Jobelle Villanueva\n" +
               "\n\nTesters\n" +
               "\n\nAnd you, the Player!\n\n" +
               "\n\nThank you for playing!";
	   
scroll_speed = 0.20;  // Adjust as needed
y = 564;

// Timer to trigger the sequence
sequence_timer = 55 * room_speed;  // 55 seconds delay
sequence_triggered = false;


// Custom timer for credits duration
credits_duration = 125 * room_speed; // Set the duration of the credits (in frames, e.g., 600 frames = 10 seconds at 60 FPS)
credits_timer = credits_duration; // Initialize the timer

sprite_displayed = false; // Track if sprite has been shown
sprite_timer = 180; // Timer to keep sprite on screen for a duration (e.g., 120 frames)


// Variable to store the sequence instance ID
my_sequence_id = noone;  // Initialize to noone (no sequence created yet)