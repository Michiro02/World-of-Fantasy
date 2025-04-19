// Draw Event of oSequence
// Draw the fade-out effect
if (show_text) {
    draw_set_alpha(fade_alpha);
    draw_set_color(c_black);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_alpha(1); // Reset alpha for other drawing operations
}

// Draw the text message after the fade-out
if (show_text && fade_alpha >= 1) {
    draw_set_color(c_white);
    draw_set_font(fnDialogue_2); // Replace with your font
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(room_width / 2, room_height / 2, "The deities have\n descended.");
}