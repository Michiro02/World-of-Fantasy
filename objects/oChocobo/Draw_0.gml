// Draw the Chocobo sprite
draw_self();

// Draw the dialogue box if dialogue is visible
if (dialogue_visible) {
    // Position the dialogue box relative to the Chocobo's position (or player's position based on the speaker)
    var dialogue_x;
    var dialogue_y;

    // If the NPC (Chocobo) is speaking, position the dialogue box above the Chocobo
    if (dialogue_sequence[dialogue_index].speaker == "npc") {
        dialogue_x = clamp(oPlayer.x - 150, 10, room_width - 300 - 10);  // Clamp relative to Chocobo's x position
        dialogue_y = clamp(oPlayer.y - 100, 10, room_height - 100 - 10); // Clamp relative to Chocobo's y position
    }
    // If the player is speaking, position the dialogue box near the player
    else {
        dialogue_x = clamp(oPlayer.x - 150, 10, room_width - 300 - 10);  // Clamp relative to player's x position
        dialogue_y = clamp(oPlayer.y - 100, 10, room_height - 100 - 10); // Clamp relative to player's y position
    }

    var dialogue_width = 300;  // Width of the dialogue box
    var dialogue_height = 50;  // Height of the dialogue box
    var border_padding = 4;

    // Get the current dialogue entry
    var current_dialogue_entry = dialogue_sequence[dialogue_index];
    var current_speaker_name;

    // Determine if the speaker is Chocobo or player
    if (current_dialogue_entry.speaker == "npc") {
        current_speaker_name = npc_name;  // Chocobo's name
    } else {
        // Get player's name from global party array
        var char_index = current_dialogue_entry.char;
        current_speaker_name = global.party[char_index].name;
    }

    var current_dialogue = current_dialogue_entry.text;

    // Set font for dialogue
    draw_set_font(fnDialogue);

    // Draw the black border for the dialogue box
    draw_set_color(c_black);
    draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                   dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);

    // Draw the blue dialogue box background
    draw_set_color(c_blue);
    draw_rectangle(dialogue_x, dialogue_y,
                   dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);

    // Draw the speaker's name and dialogue text
    draw_set_color(c_white);
    draw_text(dialogue_x + 10, dialogue_y + 10, current_speaker_name + ": " + current_dialogue);
}
