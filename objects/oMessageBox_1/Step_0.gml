// Step Event for oMessageBox
timer += 1;
if (timer >= display_time) {
    instance_destroy(); // Destroy the message box after the timer expires
} else {
    // Always follow the player (remove the pause check if unnecessary)
    if (instance_exists(player_instance)) {
        x = player_instance.x;
        y = player_instance.y - 64; // Adjust the offset as needed
		
        // Clamp the dialogue box position within the room boundaries
        x = clamp(x, box_width / 2, room_width - box_width / 2);
        y = clamp(y, box_height / 2, room_height - box_height / 2);
    }
}
