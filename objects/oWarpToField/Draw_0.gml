draw_self(); // Draw the warp sprite

if (dialogue_visible) {
    var dialogue_x = clamp(oPlayer.x - 155, 10, room_width - 300 - 10);
    var dialogue_y = clamp(oPlayer.y - 150, 190, room_height - 180 - 10);
    var dialogue_width = 305;
    var dialogue_height = 50;
    var border_padding = 4;

    var current_dialogue_entry = dialogue_sequence[dialogue_index];
    var current_speaker_name;

    if (current_dialogue_entry.speaker == "npc") {
        current_speaker_name = npc_name;
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