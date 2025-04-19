// Collision Event of oWarringTriad with the player
if (escapeDelay == 0 && !dead && !dialogue_visible && !post_battle_dialogue_visible && dialogue_cooldown <= 0) {
    dialogue_visible = true;
    global.dialogue_active = true;

    // Update the dialogue sequence based on whether the NPC has been spoken to
    if (global.npcDialogueComplete) {
        dialogue_sequence = battle_dialogue_sequence; // Use the battle dialogue
    } else {
        dialogue_sequence = initial_dialogue_sequence; // Use the initial dialogue
    }

    // Reset the dialogue index to start from the beginning
    dialogue_index = 0;
}

// Play the BGM immediately if the first dialogue entry has music
    var first_dialogue_entry = dialogue_sequence[dialogue_index];
    if (variable_struct_exists(first_dialogue_entry, "music")) {
        audio_stop_all(); // Stop any existing music
        audio_play_sound(first_dialogue_entry.music, 1, true); // Play the BGM
    }
