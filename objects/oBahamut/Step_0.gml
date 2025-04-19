escapeDelay = max(escapeDelay - 1, 0);

if (dead) {
    if (!post_battle_dialogue_visible) {
        post_battle_dialogue_visible = true;
        global.dialogue_active = true;
        image_alpha -= 0.05;
       // image_blend = c_red;
        if (image_alpha <= 0) {
            // Check if any instances of oEnemy exist before deactivating them
            if (instance_exists(oBahamut)) {
                instance_deactivate_object(oBahamut);  // Deactivate the enemy object so it doesn't interfere with the dialogue
            }
        }
    }
}

// Handle dialogue sequences
if (dialogue_visible) {
	
    if (awaiting_choice && !peaceful_exit) {
        // Handle input to select between "Yes" and "No"
        if (keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("A"))) {
            selected_choice = max(selected_choice - 1, 0);  // Move to "Yes"
            audio_play_sound(snd_Menu, 1, false);  // Play sound when navigating
        } else if (keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("D"))) {
            selected_choice = min(selected_choice + 1, 1);  // Move to "No"
            audio_play_sound(snd_Menu, 1, false);  // Play sound when navigating
        }

        // Confirm choice with Enter key
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);  // Play sound when confirming choice
            if (selected_choice == 0) {
                // Player chose "Yes"
                awaiting_choice = false;
                player_choice = 1;  // Yes
                start_battle = true;
                dialogue_visible = false;
                global.dialogue_active = false;
            } else if (selected_choice == 1) {
                // Player chose "No"
                awaiting_choice = false;
			    player_choice = 0;  // No
			    audio_stop_sound(snd_BahamutTheme);
			    audio_play_sound(snd_Overworld, 1, true);
			    bahamut_theme_played = false;  // Reset the flag for future interactions

			    // Show the peaceful "No battle" dialogue first before escape
			    dialogue_sequence = no_battle_dialogue_sequence;  // Switch to the peaceful dialogue
			    dialogue_index = 0;  // Start from the beginning of the peaceful dialogue
			    dialogue_visible = true;

			    peaceful_exit = true;  // Flag to ensure this is a peaceful exit
			}
        }
    } else {
        // Progress through the dialogue if no choice is active
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);

            // Advance to the next line of dialogue
            dialogue_index += 1;
			
		// Play specific sound for a particular dialogue index
		if (dialogue_index == 1 && !bahamut_theme_played && !peaceful_exit) {
		    audio_play_sound(snd_BahamutTheme, 1, true);
		    audio_stop_sound(snd_Overworld);
		    bahamut_theme_played = true;  // Set the flag to true after playing
		}
            // Handle the case where the choice prompt is triggered
            if (dialogue_index == array_length(dialogue_sequence) - 1 && !awaiting_choice && !peaceful_exit) {
                awaiting_choice = true;  // Show the choice (Yes/No)
            } else if (dialogue_index >= array_length(dialogue_sequence)) {
                dialogue_visible = false;
                global.dialogue_active = false;
                dialogue_index = 0;

                // Trigger escape if this was a peaceful exit
                if (peaceful_exit) {
                    escapeDelay = 180;  // Activate escape after peaceful dialogue
                }
            }
        }
    }
}



// Handle escape delay logic (after peaceful dialogue)
if (player_choice == 0 && escapeDelay > 0 && !dialogue_visible) {
    // During escape delay, the player is backing away
    if (escapeDelay == 1) {
        // Once the escape delay is over, reset dialogue sequence to original and allow player interaction
        dialogue_sequence = original_dialogue_sequence;  // Restore the original dialogue sequence
        peaceful_exit = false;  // Reset peaceful exit flag
        global.dialogue_active = false;  // Allow movement after escape delay
        player_choice = -1;  // Reset the choice so player can talk to Bahamut again
    }
}




// Post-battle dialogue handling
if (post_battle_dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);

        post_battle_dialogue_index += 1;
        if (post_battle_dialogue_index >= array_length(post_battle_dialogue_sequence)) {
            post_battle_dialogue_visible = false;
            global.dialogue_active = false;
            post_battle_dialogue_index = 0;

            // Grant Bahamut skill to the player
            var kenneth = global.party[3];
            array_push(kenneth.actions, global.actionLibrary.bahamut);

            // Mark the boss as defeated
            global.BahamutDefeated = true;

            instance_destroy();  // Only destroy Bahamut after the battle
        }
    }
}

// Battle start logic
if (start_battle) {
    // Hide dialogue box and reset variables
    dialogue_visible = false;
    global.dialogue_active = false;
    start_battle = false;  // Reset battle flag

    // Start the battle
    NewEncounter(
        choose(
            [global.enemies.Bahamut]
        ),
        sBgField
    );
    audio_play_sound(snd_LeviathanBattle, 1, true);
    audio_stop_sound(snd_BahamutTheme);
}