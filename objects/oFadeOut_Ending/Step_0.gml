/// @description Insert description here
// You can write your code in this editor
// Step Event of obj_fade
alpha += fade_speed;
if (alpha >= 1) {
    room_goto(EndSave); // Restart the game after fade-out
}
