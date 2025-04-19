// Step Event
timer += 1;
if (timer >= display_time) {
    instance_destroy();
} else {
    // Follow the player if the game is not paused
    if (!global.game_paused) {
        x = player_instance.x;
        y = player_instance.y - box_distance; // Position above the player, adjusted by box_distance

        // Calculate the width of the text
        var text_width = string_width(display) + padding; // Padding for the box border
        var text_height = string_height(display) + padding; // Padding for the box border

        // Update the box dimensions based on the text
        box_width = max(100, text_width); // Minimum width is 100
        box_height = max(32, text_height); // Minimum height is 32

        // Adjust the position based on the room's dimensions
        var room_w = room_width;
        var room_h = room_height;

        // Calculate clamping bounds
        var clamp_x_min = box_width / 2;
        var clamp_x_max = room_w - box_width / 2;
        var clamp_y_min = box_height / 2;
        var clamp_y_max = room_h - box_height / 2;

        // Clamp the position to ensure it stays within the room boundaries
        x = clamp(x, clamp_x_min, clamp_x_max);
        y = clamp(y, clamp_y_min, clamp_y_max);
    }
}
