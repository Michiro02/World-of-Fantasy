// Collision Event of oBoss (or oEnemy) with the player
if (escapeDelay == 0 && !dead && !dialogue_visible && !post_battle_dialogue_visible) {
    dialogue_visible = true;
    global.dialogue_active = true;
}