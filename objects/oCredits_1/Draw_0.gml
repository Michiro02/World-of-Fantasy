// Draw Event of the same object
draw_set_font(fnStart);

// Explicitly set the color to white before drawing the credits text
draw_set_color(c_white);

// Draw the credits text scrolling upwards
draw_text(x - 40, y, credits_text);

// Update the position of the text
y -= scroll_speed;

// Reset y position to restart the credits
if (y <= -display_get_height() - string_height(credits_text)) {
    y = display_get_height();
}

// Optionally reset the draw color after drawing (if other objects draw later)
draw_set_color(c_white);  // Reset to default white if needed
