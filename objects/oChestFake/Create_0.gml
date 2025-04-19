if (global.chestDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}

escapeDelay = 0;
dead = false;
start_battle = false;

dialogue_visible = false; // Controls if the dialogue is shown
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 20; // The range within which the dialogue is triggered
npc_name = " "; // The name of the enemy/NPC

// Define the dialogue sequence (you can keep or remove entries as needed)
dialogue_sequence = [
    { speaker: "npc", text: "Monsters!!" },
	

];
