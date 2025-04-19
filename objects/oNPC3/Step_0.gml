var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);

// Check if the player is within range to interact with the NPC
if (distance_to_player < dialogue_range) {
    // Show the ChatUI sprite when the player is near the NPC
    chat_ui_visible = true;


if (distance_to_player < dialogue_range && keyboard_check_pressed(vk_enter)) {
    if (!global.game_paused) { // Check if the game is not paused
        audio_play_sound(snd_Menu, 1, false); // Play the sound when "Enter" is pressed

        if (!dialogue_visible) {
            dialogue_visible = true; // Show dialogue
            global.dialogue_active = true; // Set the global flag

            if (global.dog_found) {
                dialogue_sequence = [
                    { speaker: "player", char: 0, text: "Here is your dog, Amethyst." },
                    { speaker: "npc", text: "Oh, thank you for finding Juza!" },
                    { speaker: "npc", text: "Since you found my dog, I\nwill give you a reward." },
                    { speaker: "npc", text: "Here is your reward, the\nBlazing Magic for Andrei." },
                    { speaker: "player", char: 1, text: "Wow, thank you very much!" }
                ];

                if (!dog_found) {
                    // Create the dog instance at the NPC's position
                    npc_dog_instance = instance_create_layer(220, 156, "Instances", oDog);
                    npc_dog_instance.dialogue_visible = false; // Ensure the dog doesn't have dialogue
                    npc_dog_instance.non_interactive = true; // Set the dog to be non-interactive
                    dog_found = true; // Mark the dog as found at the NPC
                }
            }
        } else {
            dialogue_index += 1;
            if (dialogue_index >= array_length(dialogue_sequence)) {
                dialogue_visible = false; // Hide dialogue when finished
                global.dialogue_active = false; // Clear the global flag
                dialogue_index = 0; // Reset dialogue index

                if (global.dog_found && !global.dog_reward_given) {
                    // Reward the player with the Blazing skill
                    var andrei = global.party[1]; // Assuming Andrei is the second character
                    array_push(andrei.actions, global.actionLibrary.blazing);

                    // Mark the reward as given
                    global.dog_reward_given = true;
                }
            }
        }
    }
}

} else {
    // Hide the ChatUI sprite when the player is far away
    chat_ui_visible = false;
}