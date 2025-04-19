//create event
previous_room = room; // Initialize with current room
encounter_cooldown = 0; // Frames before another encounter can occur
cooldown_duration = 60; // 1 seconds (60 frames = 1 second)

if (!variable_global_exists("encounter_timer")) {
    encounter_timer = 0;
    encounter_threshold = irandom_range(180, 300); // 3–5 seconds
}



// Check if we are loading a game
if (global.load_game_flag) {
    scr_load_game(global.selected_slot); // Load the selected save slot
    global.load_game_flag = false; // Reset the flag after loading
}

global.game_paused = false;

spdWalk = 1.1;
animIndex = 0;
canMove = true;

function FourDirectionAnimate() {
    // Update Sprite
    var _animLength = sprite_get_number(sprite_index) / 4;
    image_index = animIndex + (((direction div 90) mod 4) * _animLength);
    animIndex += sprite_get_speed(sprite_index) / 60;

    // If animation would loop on the next game step
    if (animIndex >= _animLength) {
        animationEnd = true;    
        animIndex -= _animLength;
    } else {
        animationEnd = false;
    }
}