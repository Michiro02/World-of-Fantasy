// Step Event for oChocobo
// Distance check between player and Chocobo for interaction
var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);

if (!global.game_paused && !global.dialogue_active) {
    // Decrease the movement timer each step
    movement_timer -= 1;

    if (movement_timer <= 0) {
        // Toggle movement state when the timer reaches 0
        movement_state = !movement_state;  // Switch between true (moving) and false (stopped)
        movement_timer = 360;  // Reset timer to 5 seconds (300 steps)
    }

    // Only move if the movement_state is true (Chocobo is moving)
    if (movement_state) {
        var _inputH = 0;  // Ensure _inputH is initialized
        var _inputV = 0;  // Ensure _inputV is initialized

        // Instead of keyboard input, we'll randomize the movement every few steps
        if (change_direction_time > 0) {
            change_direction_time -= 1;  // Countdown to next direction change

            // Maintain current direction by converting direction to inputH and inputV
            _inputH = lengthdir_x(1, direction);  // Move according to current direction
            _inputV = lengthdir_y(1, direction);
        } else {
            // Randomize direction when the timer reaches 0
            _inputH = irandom_range(-1, 1);  // Random horizontal movement (-1, 0, or 1)
            _inputV = irandom_range(-1, 1);  // Random vertical movement (-1, 0, or 1)

            // Make sure it doesn't stop moving completely
            if (_inputH == 0 && _inputV == 0) {
                _inputH = irandom_range(-1, 1);  // Randomize again if both are 0
            }

            // Reset timer for the next random direction change
            change_direction_time = irandom_range(60, 120);  // Change direction every 1-2 seconds

            // Calculate the input magnitude and direction
            var _inputM = sqrt(sqr(_inputH) + sqr(_inputV));  // Magnitude of the input vector
            if (_inputM != 0) {
                var _inputD = point_direction(0, 0, _inputH, _inputV);  // Calculate direction
                _inputH /= _inputM;  // Normalize the input
                _inputV /= _inputM;
                direction = _inputD;  // Set the direction
            }

            // Set image speed for animation if it's moving
            image_speed = 1;
        }

        // Call the animation function to update sprites based on direction
        FourDirectionAnimate();

        // Apply movement based on speed and direction
        x += spdWalk * _inputH;
        y += spdWalk * _inputV;

        // Clamp position within room bounds to prevent it from walking out of the screen
        x = clamp(x, 0, room_width);
        y = clamp(y, 0, room_height);
    } else {
        // If not moving, stop animation
        image_speed = 0;
    }
} else {
    // Stop movement and animation if paused or in dialogue
    image_speed = 0;
    animIndex = 0;
}

if (distance_to_player < dialogue_range && keyboard_check_pressed(vk_enter)) {
    if (!global.game_paused) { // Check if the game is not paused
        audio_play_sound(snd_Menu, 1, false); // Play the sound when the interaction key is pressed

        if (!dialogue_visible) {
            // Show dialogue
            dialogue_visible = true;
            global.dialogue_active = true;  // Set global flag to indicate dialogue is active
        } else {
            // Proceed to next dialogue entry
            dialogue_index += 1;

            // If all dialogue has been shown, hide it and reset
            if (dialogue_index >= array_length(dialogue_sequence)) {
                dialogue_visible = false; // Hide dialogue
                global.dialogue_active = false;  // Clear the global dialogue flag
                dialogue_index = 0;  // Reset the dialogue index to 0 for next interaction
            }
        }
    }
}