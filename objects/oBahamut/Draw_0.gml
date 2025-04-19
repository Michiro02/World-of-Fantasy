if (escapeDelay > 0) {
    draw_set_font(fnOpenSansPX);
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_bottom);
    draw_text(x, bbox_top - 4, "?");
	
	// Reset alignment to default values after drawing text
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
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

    if (current_dialogue_entry.speaker == "enemy") {
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

    if (current_dialogue_entry.speaker == "enemy") {
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


if (awaiting_choice) {
    var choice_x = oPlayer.x - 150;
    var choice_y = oPlayer.y - 50;

    // Draw the UI box stretched
    draw_sprite_stretched(sBox, 0, choice_x - 10, choice_y, 180, 60); // Adjust width and height as needed

    draw_set_font(fnOpenSansPX);
    draw_set_color(c_white);
    draw_text(choice_x + 10, choice_y + 10, "Will you fight Bahamut?"); // Adjust positioning as needed

    // Highlight the selected choice ("Yes" or "No")
    draw_set_color(selected_choice == 0 ? c_yellow : c_white);
    draw_text(choice_x + 20, choice_y + 40, "Yes");

    draw_set_color(selected_choice == 1 ? c_yellow : c_white);
    draw_text(choice_x + 120, choice_y + 40, "No");

    // Draw the pointer for the selected choice
    var pointer_x = selected_choice == 0 ? choice_x + 25 : choice_x + 125; // Adjust pointer position based on selection
    var pointer_y = choice_y + 45;
    draw_sprite(sPointer, 0, pointer_x, pointer_y); // Draw the pointer UI
}