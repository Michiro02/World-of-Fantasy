var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);

// Check if the player is within range to interact with the NPC
if (distance_to_player < dialogue_range) {
    chat_ui_visible = true;

    if (keyboard_check_pressed(vk_enter)) {
        if (!global.game_paused) { // Check if the game is not paused
            audio_play_sound(snd_Menu, 1, false); // Play the sound when "F" is pressed

            if (!dialogue_visible) {
                dialogue_visible = true; // Show dialogue
                global.dialogue_active = true; // Set the global flag
            } else {
                dialogue_index += 1;
                if (dialogue_index >= array_length(dialogue_sequence)) {
                    dialogue_visible = false; // Hide dialogue when finished
                    global.dialogue_active = false; // Clear the global flag
                    dialogue_index = 0; // Reset dialogue index

                    // When the first NPC dialogue is completed, trigger the Warring Triad event
                    if (!global.npcDialogueComplete && !global.newDialogue) {
                        global.npcDialogueComplete = true; 
                    }

                    // If the Warring Triad is defeated, transition to the ending scene
                    if (global.newDialogue) {
                        room_goto(Room20);
                    }
                }
            }
        }
    }
} else {
    chat_ui_visible = false;
}
