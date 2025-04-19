// Draw Event of oCredits
draw_set_font(fnPixeled);
draw_set_color(c_white);
draw_self();

// Define the scale for the sprite
var scale_x = 0.5;  // Scale factor for width
var scale_y = 0.5;  // Scale factor for height

// Draw the credits text scrolling upwards
draw_text(x + 10, y, credits_text);

// Calculate the sprite's position to scroll with the text and be centered horizontally
var sprite_x = (room_width - (sprite_get_width(WoF_2) * scale_x)) / 2; // Centering based on room width
var sprite_y = y + string_height(credits_text) + 150; // Position the sprite below the credits text

// Draw the resized sprite at the calculated position
draw_sprite_ext(WoF_2, 0, sprite_x, sprite_y, scale_x, scale_y, 0, c_white, 1);

// Update the position of the text and sprite (since both use `y`)
if (!sprite_displayed) {
    y -= scroll_speed;
}