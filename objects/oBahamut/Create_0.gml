//create
if (global.BahamutDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}

escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Bahamut";
bahamut_theme_played = false;  // Track if the theme has already played


// Choice handling variables
awaiting_choice = false;  // New variable to track if a choice is active
selected_choice = 0;  // 0 = "Yes", 1 = "No" (default starts on "Yes")
player_choice = -1;  // -1 = no choice made, 0 = No, 1 = Yes
peaceful_exit = false;


post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
    { speaker: "player", char: 1, text: "Mighty Bahamut, we come to seek\nyour divine assistance!" },
    { speaker: "enemy", text: "What makes you think you are\nworthy of my strength, brave mortals?" },
    { speaker: "player", char: 3, text: "Our realm is on the brink of\ndestruction, and we need your power to\nrestore balance." },
    { speaker: "enemy", text: "A noble cause, yet many have\nfailed in their quest. Can you prove\nyourselves?" },
	{ speaker: "player", char: 0, text: "We will not back down, Bahamut! We\nwill fight for our world, no matter\nthe cost!"},
	{ speaker: "enemy", text: "Very well... If you seek my\npower, you must first face me in battle!"},
    { speaker: "enemy", text: "Will you face me in battle and\nprove your strength?" }  // Prompt for the choice
];

original_dialogue_sequence = dialogue_sequence;

// Post-battle dialogues and peaceful exit dialogues
post_battle_dialogue_sequence = [
    { speaker: "player", char: 1, text: "We have triumphed! Will you now\nlend us your strength?" },
    { speaker: "enemy", text: "You have fought valiantly. I\nwill grant you my power for this noble\nquest." },
    { speaker: "player", char: 3, text: "Thank you, Bahamut! Together, we\nwill bring hope back to our world!" }
];

no_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "We are not ready to face you in\nbattle." },
    { speaker: "enemy", text: "Then leave, and do not return\nuntil you are prepared to prove your\nworth." },
];