// Draw Event
// Draw the sBox sprite stretched to the calculated width and height
draw_sprite_stretched(sBox, 0, x - box_width / 2, y - box_height / 2, box_width, box_height);

// Draw the text inside the box with padding
draw_set_color(c_white);
draw_set_font(fnDialogue_1); // Set the font to your dialogue font
draw_text(x - box_width / 2 + text_offset_x, y - box_height / 2 + text_offset_y, display); // Draw the message text inside the box with padding
