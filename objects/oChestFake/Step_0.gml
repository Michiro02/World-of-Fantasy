escapeDelay = max(escapeDelay-1, 0);

if (dead) {
    image_alpha -= 0.05;
    image_blend = c_red;
    if (image_alpha <= 0) 
	instance_destroy();
}

var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);


// Check if the player is within range to interact with the NPC
if (distance_to_player < dialogue_range) {
    // Show the ChatUI sprite when the player is near the NPC
    chat_ui_visible = true;
	
// Check if the player is within range to interact with the enemy
if (distance_to_player < dialogue_range) {
    // If player presses Enter and the dialogue isn't active yet, start the dialogue
    if (keyboard_check_pressed(vk_enter) && !global.dialogue_active && !dialogue_visible) {
		if (!global.game_paused){
        dialogue_visible = true;
        global.dialogue_active = true; // Pause gameplay for dialogue
        dialogue_index = -1; // Ensure we start from the beginning of the sequence
    }
}
    // Handle the dialogue when visible
    if (dialogue_visible) {
        // Progress dialogue with Enter key
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false); // Play sound on key press

            // Increment the dialogue index to move to the next dialogue
            dialogue_index += 1;

            // If we've gone past the last dialogue, hide and start the battle
            if (dialogue_index >= array_length(dialogue_sequence)) {
                dialogue_visible = false;
                global.dialogue_active = false;
                start_battle = true;
                dialogue_index = 0; // Reset dialogue index
            }
        }
    }

    // If the dialogue is over, start the battle
    if (start_battle) {
        // Hide dialogue box and reset variables
        dialogue_visible = false;
        global.dialogue_active = false;
        start_battle = false; // Reset battle flag

        // Start the battle
        NewEncounter(
            choose(
                [global.enemies.Mimic]
            ),
            sBgNewBoss
        );
        audio_play_sound(snd_IronGiant, 1, true);
        audio_stop_sound(snd_Tower);
		global.chestDefeated = true;
        instance_destroy(); // Destroy the enemy after the battle
    }
}

} else {
    // Hide the ChatUI sprite when the player is far away
    chat_ui_visible = false;
}
