// Step Event
if (!sprite_displayed) {
    // Continue scrolling the credits
    if (y > -string_height(credits_text)) {
        y -= scroll_speed;
    } else {
        // Credits text has finished, now show the sprite
        sprite_displayed = true;
    }
} //else {
    // Start countdown to fade out
  //  sprite_timer--;
  //  if (sprite_timer <= 0) {
        // Create the fade-out object to start the fade-out effect
  //      instance_create_layer(0, 0, "Instances", oFadeOut_Ending);
   //     instance_destroy(); // Destroy the credits object after creating the fade-out object
   // }
//}

// Timer to trigger the sequence
if (!sequence_triggered) {
    sequence_timer -= 1;
    show_debug_message("Sequence Timer: " + string(sequence_timer)); // Debug the timer value
    if (sequence_timer <= 0) {
        show_debug_message("Creating Sequence..."); // Debug when the sequence is created
        // Create the sequence on a specific layer at a specific position
        my_sequence_id = layer_sequence_create("Assets_2", x + 340, 250, Sequence6); // Fixed y position for testing
        sequence_triggered = true;  // Ensure the sequence is only triggered once
    }
}

// Custom credits timer
credits_timer -= 1;
if (credits_timer <= 0) {
    // Trigger the fade-out effect when the custom timer reaches 0
    instance_create_layer(0, 0, "Instances", oFadeOut_Ending);
    instance_destroy(); // Destroy the credits object after creating the fade-out object
}