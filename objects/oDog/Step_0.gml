// Step event
var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);
if (distance_to_player < dialogue_range && keyboard_check_pressed(vk_enter) && !dog_found && !non_interactive) {
	 if (!global.game_paused) { // Check if the game is not paused
    audio_play_sound(snd_Menu, 1, false); // Play the sound when "Enter" is pressed

    if (!dialogue_visible) {
        dialogue_visible = true; // Show dialogue
        global.dialogue_active = true; // Set the global flag
    } else {
        dialogue_index += 1;
        if (dialogue_index >= array_length(dialogue_sequence)) {
            dialogue_visible = false; // Hide dialogue when finished
            global.dialogue_active = false; // Clear the global flag
            dialogue_index = 0; // Reset dialogue index

            dog_found = true; // Mark the dog as found
            global.dog_found = true; // Set the global variable to indicate the dog has been found
            instance_destroy(); // Remove the dog object
			}
        }
    }
}
