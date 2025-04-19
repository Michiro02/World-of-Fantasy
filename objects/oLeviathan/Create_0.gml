if (global.LeviathanDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}

escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Leviathan"; // Set this to your enemy's actual name

// Choice handling variables
awaiting_choice = false;  // New variable to track if a choice is active
selected_choice = 0;  // 0 = "Yes", 1 = "No" (default starts on "Yes")
player_choice = -1;  // -1 = no choice made, 0 = No, 1 = Yes
peaceful_exit = false;

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
    { speaker: "player", char: 3, text: "Leviathan, we seek your aid\nagainst the darkness encroaching upon\nour world." },
    { speaker: "enemy", text: "What makes you think I would\nassist mere mortals?" },
    { speaker: "player", char: 0, text: "We must defeat the evil that\nthreatens everyone, including you." }, // Milan
    { speaker: "enemy", text: "Prove your worth by facing me." },
];

original_dialogue_sequence = dialogue_sequence;

post_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "Now, will you lend us your\nstrength?" }, // Milan
    { speaker: "enemy", text: "You have proven yourselves,\nmortals. Summon me when you truly need\nmy might." },
    { speaker: "player", char: 3, text: "We won't hesitate to call upon\nyou when danger returns." }
];


no_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "We're not prepared to face you\nin combat yet." },
    { speaker: "enemy", text: "Then turn back, and do not\nreturn until you are worthy." },
];

