// Step Event of oSequence
sequence_timer++;

// After 40 seconds (2400 frames at 60 FPS), start the fade-out and show the text
if (sequence_timer >= 2400 && !show_text) {
    show_text = true; // Set the flag to show the text
    restart_timer = 0; // Reset the restart timer
}

// Handle the fade-out effect
if (show_text) {
    fade_alpha += 1 / fade_out_duration; // Gradually increase the fade alpha
    if (fade_alpha >= 1) {
        fade_alpha = 1; // Clamp the alpha value to 1
    }

    // After 10 seconds (600 frames at 60 FPS), restart the game
    restart_timer++;
    if (restart_timer >= 600) {
        room_goto(EndSave); 
    }
}