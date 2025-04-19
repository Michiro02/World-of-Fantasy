// Step Event
var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);

if (dialogue_visible) {
    // Only proceed when the dialogue is visible
    if (!global.game_paused) { // Check if the game is not paused
        if (!global.dialogue_active) {
            global.dialogue_active = true;  // Set global flag to indicate dialogue is active
        }

        // Move to the next dialogue in the sequence when 'Enter' is pressed
        if (keyboard_check_pressed(vk_enter)) {
            dialogue_index += 1;
			audio_play_sound(snd_Menu,1,false);
			
            // Check if the initial dialogue sequence is completed
            if (!initial_dialogue_completed) {
                if (dialogue_index >= array_length(dialogue_sequence)) {
                    // End of initial dialogue, set the flag and reset dialogue index
                    dialogue_visible = false;
                    global.dialogue_active = false;
                    dialogue_index = 0;
                    initial_dialogue_completed = true;  // Set the flag to indicate dialogue is completed
                }
            } else {
                // For repeated interaction, just show the "Good luck to your journey" dialogue
                if (dialogue_index >= array_length(repeat_dialogue)) {
                    dialogue_visible = false;
                    global.dialogue_active = false;
                    dialogue_index = 0;  // Reset dialogue index for future interactions
                }
            }
        }
    }
} else if (distance_to_player < dialogue_range && keyboard_check_pressed(vk_enter)) {
    // When the player comes near and presses Enter, show the dialogue
    dialogue_visible = true;
    audio_play_sound(snd_Menu, 1, false);  // Play the sound when Enter is pressed

    if (initial_dialogue_completed) {
        // If the initial dialogue is completed, set the repeat dialogue
        dialogue_sequence = repeat_dialogue;
    }
}