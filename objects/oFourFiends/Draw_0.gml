//draw
// Existing draw code
if (escapeDelay > 0) {
    draw_set_font(fnOpenSansPX);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x, bbox_top - 4, "?");
}
draw_self();

// Dialogue drawing code
if (dialogue_visible) {
    var dialogue_x = clamp(oPlayer.x - 150, 10, room_width - 300 - 10);  // Adjust and clamp position relative to the player
    var dialogue_y = clamp(oPlayer.y - 95, -10, room_height - 50 - 10);  // Adjust and clamp position relative to the player
    var dialogue_width = 300;  // Width of the dialogue box
    var dialogue_height = 50;  // Height of the dialogue box
    var border_padding = 4;

    var current_dialogue_entry = dialogue_sequence[dialogue_index];
    var current_speaker_name;

    // Check if the speaker is an enemy or a player character
    if (current_dialogue_entry.speaker == "Miglione" || 
        current_dialogue_entry.speaker == "Barbariccia" || 
        current_dialogue_entry.speaker == "Cagnazzo" || 
        current_dialogue_entry.speaker == "Rubicante") {
        
        // Set the name based on the specific enemy
        current_speaker_name = current_dialogue_entry.speaker;
    } else if (current_dialogue_entry.speaker == "enemy") {
        // Fallback to the general enemy name if the speaker is just "enemy"
        current_speaker_name = enemy_name;
    } else {
        var char_index = current_dialogue_entry.char;
        current_speaker_name = global.party[char_index].name;
    }

    var current_dialogue = current_dialogue_entry.text;

    draw_set_font(fnDialogue);

    draw_set_color(c_black);
    draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                   dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);

    draw_set_color(c_blue);
    draw_rectangle(dialogue_x, dialogue_y,
                   dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);

    draw_set_color(c_white);
    draw_text(dialogue_x + 10, dialogue_y + 10, current_speaker_name + ": " + current_dialogue);
}

if (post_battle_dialogue_visible) {
    var dialogue_x = clamp(oPlayer.x - 150, 10, room_width - 300 - 10);  // Adjust and clamp position relative to the player
    var dialogue_y = clamp(oPlayer.y - 95, -10, room_height - 50 - 10);  // Adjust and clamp position relative to the player
    var dialogue_width = 300;  // Width of the dialogue box
    var dialogue_height = 50;  // Height of the dialogue box
    var border_padding = 4;

    var current_dialogue_entry = post_battle_dialogue_sequence[post_battle_dialogue_index];
    var current_speaker_name;

    // Check if the speaker is an enemy or a player character
    if (current_dialogue_entry.speaker == "Miglione" || 
        current_dialogue_entry.speaker == "Barbariccia" || 
        current_dialogue_entry.speaker == "Cagnazzo" || 
        current_dialogue_entry.speaker == "Rubicante") {
        
        // Set the name based on the specific enemy
        current_speaker_name = current_dialogue_entry.speaker;
    } else if (current_dialogue_entry.speaker == "enemy") {
        // Fallback to the general enemy name if the speaker is just "enemy"
        current_speaker_name = enemy_name;
    } else {
        var char_index = current_dialogue_entry.char;
        current_speaker_name = global.party[char_index].name;
    }

    var current_dialogue = current_dialogue_entry.text;

    draw_set_font(fnDialogue);

    draw_set_color(c_black);
    draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                   dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);

    draw_set_color(c_blue);
    draw_rectangle(dialogue_x, dialogue_y,
                   dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);

    draw_set_color(c_white);
    draw_text(dialogue_x + 10, dialogue_y + 10, current_speaker_name + ": " + current_dialogue);
}