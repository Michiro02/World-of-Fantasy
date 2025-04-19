// Update box dimensions based on the current message length
var text_width = string_width(message) + 16; // Add some padding
var text_height = string_height(message) + 16; // Add some padding
box_width = max(102, text_width); 
box_height = max(62, text_height); 

// Draw the sBox sprite stretched to the calculated width and height
draw_sprite_stretched(sBox, 0, x + box_width - 380, y + box_height - 30, box_width, box_height);

draw_set_color(c_white);
draw_set_font(fnDialogue_2); // Set the font to your dialogue font
draw_text(x + box_width - 370, y + box_height - 10, message); // Draw the message text inside the box with some padding

