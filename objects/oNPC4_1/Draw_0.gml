// First, draw the NPC sprite
draw_self();

// Draw the ChatUI sprite if the player is near the NPC
if (chat_ui_visible) {
    draw_sprite(ChatUI, 0, x + 2, y - 25); // Draw the sprite slightly above the NPC
}

// Then, draw the dialogue if it's visible
if (dialogue_visible) {
     var dialogue_x = clamp(oPlayer.x - 150, 10, room_width - 300 - 10);  // Adjust and clamp position relative to the player
    var dialogue_y = clamp(oPlayer.y - 150, 190, room_height - 180 - 10);  // Adjust and clamp position relative to the player
    var dialogue_width = 300;  // Width of the dialogue box
    var dialogue_height = 50;  // Height of the dialogue box
    var border_padding = 4;

  // Get the current dialogue entry
    var current_dialogue_entry = dialogue_sequence[dialogue_index];
    var current_speaker_name;

    if (current_dialogue_entry.speaker == "npc") {
        current_speaker_name = npc_name;
    } else {
        var char_index = current_dialogue_entry.char;
        current_speaker_name = global.party[char_index].name;
    }

    var current_dialogue = current_dialogue_entry.text;

    // Set the font for smaller text
    draw_set_font(fnDialogue);

    // Draw the black border (background rectangle)
    draw_set_color(c_black);
    draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                   dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);

    // Draw the dialogue box background
    draw_set_color(c_blue);
    draw_rectangle(dialogue_x, dialogue_y,
                   dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);

    // Draw the speaker's name and dialogue text
    draw_set_color(c_white);
    draw_text(dialogue_x + 5, dialogue_y + 10, current_speaker_name + ": " + current_dialogue);
}