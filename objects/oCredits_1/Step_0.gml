// Step Event of obj_credits
if (y > -string_height(credits_text)) {
    y -= scroll_speed;
} else {
    // Create the fade-out object to start the fade-out effect
    instance_create_layer(0, 0, "Instances", oFadeOut_1);
    instance_destroy(); // Destroy the credits object after creating the fade-out object
}

// Check for skip button (e.g., pressing the enter or clicking the mouse)
if (keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left)) {
    // Create the fade-out object to start the fade-out effect
    instance_create_layer(0, 0, "Instances", oFadeOut_1);
    instance_destroy(); // Destroy the credits object after creating the fade-out object
}
