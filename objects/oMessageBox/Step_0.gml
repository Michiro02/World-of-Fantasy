//step
timer += 1;
if (timer >= display_time) {
    instance_destroy();
} else {
    // Follow the player if the game is not paused
    if (!global.game_paused) {
        x = player_instance.x;
        y = player_instance.y - 64; // Adjust the offset as needed
		
		// Clamp the dialogue box position within the room boundaries
        x = clamp(x, box_width / 2, room_width - box_width / 2);
        y = clamp(y, box_height / 2, room_height - box_height / 2);
    }
}