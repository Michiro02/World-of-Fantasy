if (global.gilgameshDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}
escapeDelay = 0;
dead = false;