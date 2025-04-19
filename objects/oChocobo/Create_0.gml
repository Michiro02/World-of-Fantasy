// Create Event
spdWalk = 1;          // Speed at which the Chocobo moves
direction = irandom(3) * 90;  // Random initial direction (0, 90, 180, or 270 degrees)
change_direction_time = irandom_range(60, 120);  // Time before changing direction (1-2 seconds)

movement_timer = 240;  // Timer for 5 seconds (assuming 60 steps per second, 60 * 5 = 300)
movement_state = true; // Start in the "moving" state
animIndex = 0;

dialogue_visible = false;  
dialogue_index = 0;        
dialogue_range = 30;      


npc_name = "Chocobo";


dialogue_sequence = [
    { speaker: "npc", text: "Kweh! Hello there, traveler!" },
    { speaker: "player", char: 0, text: "A Chocobo! Can we ride you?" }, // Milan
    { speaker: "npc", text: "Kweh! I'm not in the mood right\nnow, maybe later." },
    { speaker: "player", char: 2, text: "Aww, come on! Just for a quick\nride?" }, // Hannah
    { speaker: "npc", text: "Kweh! I'm busy walking around.\nMaybe when I'm done!" }
];

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
