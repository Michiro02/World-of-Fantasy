// Draw Event of oCredits
draw_set_font(fnPixeled);
draw_set_color(c_white);
draw_self();

// Draw the credits text scrolling upwards
draw_text(x - 50, y, credits_text);

// Update the position of the text
y -= scroll_speed;

// Reset y position to restart the credits
if (y <= -display_get_height() - string_height(credits_text)) {
    y = display_get_height();
}
