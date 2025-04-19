// Step Event of oCredits

// Custom credits timer
if (y > -string_height(credits_text)) {
    y -= scroll_speed;
} else {
    // Trigger the fade-out effect when the custom timer reaches 0
    instance_create_layer(0, 0, "Instances", oFadeOut_2);
    instance_destroy(); // Destroy the credits object after creating the fade-out object
}

// Check for skip button (e.g., pressing the enter)
if (keyboard_check_pressed(vk_enter)) {
    // Create the fade-out object to start the fade-out effect
   instance_create_layer(0, 0, "Instances", oFadeOut_2);
    instance_destroy(); // Destroy the credits object after creating the fade-out object
}
