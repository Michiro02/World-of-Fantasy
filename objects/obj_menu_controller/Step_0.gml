// Step Event
if (is_intro) {
    // Intro sequence logic
    switch (intro_step) {
        case 0: // Fade in with initial text
            fade_alpha += 0.02;
            if (fade_alpha >= 1) {
                fade_alpha = 1;
                timer = 290; // Set delay
                intro_step = 1;
				audio_play_sound(menu_music, 0, true); 
			    menu_music_playing = true;
            }
            break;

        case 1: // Display first image after text fades out
            if (timer > 0) {
                timer -= 1;
            } else {
                fade_alpha -= 0.02;
                if (fade_alpha <= 0) {
                    fade_alpha = 0;
                    current_image_index = 0; // Show first image
                    timer = 90;
                    intro_step = 2;
                }
            }
            break;

        case 2: // Fade in the first image
            fade_alpha += 0.02;
            if (fade_alpha >= 1) {
                fade_alpha = 1;
                timer = 90;
                intro_step = 3;
            }
            break;

        case 3: // Fade out the first image
            if (timer > 0) {
                timer -= 1;
            } else {
                fade_alpha -= 0.02;
                if (fade_alpha <= 0) {
                    fade_alpha = 0;
                    current_image_index = 1; // Show second image
                    timer = 90;
                    intro_step = 4;
                }
            }
            break;

        case 4: // Fade in the second image and start background fade
            fade_alpha += 0.02;
            if (fade_alpha >= 1) {
                fade_alpha = 1;
                timer = 90;
                intro_step = 5;
            }
            break;

        case 5: // Fade out the second image
            if (timer > 0) {
                timer -= 1;
            } else {
                fade_alpha -= 0.02;
                if (fade_alpha <= 0) {
                    fade_alpha = 0;
                    is_intro = false; // End intro sequence
					bg_fade_started = true; // Start background fade-in here.
                }
            }
            break;
    }
}

if (!is_intro && global.menu_state == "main") {
    // Start the fade-in transition if it hasn't started yet
    if (!menu_fade_in_started) {
        menu_fade_in_started = true;
        menu_fade_alpha = 0; // Reset fade alpha
    }

    // Increase the alpha to create a fade-in effect
    if (menu_fade_alpha < 1) {
        menu_fade_alpha += 0.02; // Adjust speed as needed
        if (menu_fade_alpha > 1) menu_fade_alpha = 1; // Cap alpha at 1
    }
} else {
    // Reset menu fade if not on the main menu
    menu_fade_alpha = 0;
    menu_fade_in_started = false;
}


// Background fade logic (after second image starts fading in)
if (bg_fade_started && bg_fade_alpha < 1) {
    bg_fade_alpha += 0.01; // Adjust the fade speed if needed
    if (bg_fade_alpha > 1) bg_fade_alpha = 1; // Ensure full opacity
}
    if (!is_intro) {
    if (global.menu_state == "main") {
        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
            selected_option -= 1;
            if (selected_option < 0) selected_option = 3;
            audio_play_sound(snd_Menu, 1, false);
        }

        if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
            selected_option += 1;
            if (selected_option > 3) selected_option = 0;
            audio_play_sound(snd_Menu, 1, false);
        }

        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);

            if (selected_option == 0) {
                room_goto(RoomStart_1); // Start the game
            } else if (selected_option == 1) {
                global.menu_state = "settings";
                selected_option = 0;
            } else if (selected_option == 2) {
                global.menu_state = "load_select";
            } else if (selected_option == 3) {
                game_end(); // Quit the game
            }
        }
} else if (global.menu_state == "settings") {
    // Handle Settings menu navigation
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        selected_option -= 1;
        if (selected_option < 0) selected_option = 1; // Wrap around between "Controls" and "Volume"
        audio_play_sound(snd_Menu, 1, false);
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        selected_option += 1;
        if (selected_option > 1) selected_option = 0; // Wrap around between "Controls" and "Volume"
        audio_play_sound(snd_Menu, 1, false);
    }

    // Automatically adjust the volume in the "Volume" option without needing Enter
    if (selected_option == 1) { // If "Volume" is selected
        if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
            audio_play_sound(snd_Menu, 1, false); // Play sound when adjusting
            global.volume = max(global.volume - 0.05, 0); // Decrease volume, minimum 0
            audio_master_gain(global.volume);
        }

        if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
            audio_play_sound(snd_Menu, 1, false); // Play sound when adjusting
            global.volume = min(global.volume + 0.05, 1); // Increase volume, maximum 1
            audio_master_gain(global.volume);
        }
    }

    // Execute the selected action if "Controls" is selected
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        if (selected_option == 0) {
            // Enter Controls menu
            global.menu_state = "controls";
        }
    }

    // Return to main menu
    if (keyboard_check_pressed(vk_escape)) {
        audio_play_sound(snd_Menu, 1, false);
        global.menu_state = "main"; // Go back to main menu
        selected_option = 1; // Keep Settings highlighted when returning
    }
} else if (global.menu_state == "controls") {
    // Handle Controls menu
    if (keyboard_check_pressed(vk_escape)) {
        audio_play_sound(snd_Menu, 1, false);
        global.menu_state = "settings"; // Go back to Settings menu
        selected_option = 0; // Keep Controls highlighted when returning
    }
} else if (global.menu_state == "load_select") {
    // Handle Load Game navigation
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        global.selected_slot -= 1;
        if (global.selected_slot < 1) global.selected_slot = 3; // Wrap around
        audio_play_sound(snd_Menu, 1, false);
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        global.selected_slot += 1;
        if (global.selected_slot > 3) global.selected_slot = 1; // Wrap around
        audio_play_sound(snd_Menu, 1, false);
    }

    // Handle selecting a save slot to load
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        var slot_filename = "savegame" + string(global.selected_slot) + ".txt";
        if (file_exists(slot_filename)) {
            global.load_game_flag = true; // Set a flag to indicate loading a game
            room_goto(RoomStart_1); // Transition to the game room
        } else {
            // Show a message if no save file is found
            var msg_box = instance_create_layer(x, y, "UI", oMessageBox_1);
            msg_box.message = "No save file found in Slot " + string(global.selected_slot);
        }
    }

    // Return to main menu
    if (keyboard_check_pressed(vk_escape)) {
        global.menu_state = "main"; // Return to main menu
        audio_play_sound(snd_Menu, 1, false);
		}
	}
}
//if (!is_intro && (global.menu_state == "main" || global.menu_state == "settings" || global.menu_state == "load_select" || global.menu_state == "controls")) {
    // Play main menu music if not already playing
//    if (!menu_music_playing) {
 //       audio_play_sound(menu_music, 1, true); // Loop the sound
//        menu_music_playing = true;
//    }
//} else {
    // Stop music when leaving the menu system entirely
//    if (menu_music_playing) {
//        audio_stop_sound(menu_music);
 //       menu_music_playing = false;
//		 }
//	}
//}