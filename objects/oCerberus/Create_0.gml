if (global.cerberusDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}

escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Cerberus"; // Set this to your enemy's actual name

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
	{ speaker: "player", char: 4, text: "Wait..." }, //Jobelle
	{ speaker: "player", char: 4, text: "It looks like the monster is\nasleep..."}, //Jobelle
	{ speaker: "player", char: 1, text: "We should move quietly."}, //Andrei
	{ speaker: "player", char: 3, text: "Pfft.. Don't worry too much."}, //Kenneth
	{ speaker: "player", char: 3, text: "It looks like it's in a deep\nsleep."}, //Kenneth
	{ speaker: "player", char: 3, text: "Watch this.... *Trips down*.."}, //Kenneth
    { speaker: "enemy", text: "Nnnggh Roaaar." },
	{ speaker: "player", char: 2, text: "Ugh!!! KENNETH!!!"}, //Hannah	
	{ speaker: "player", char: 3, text: "Oopsie.. My bad."}, //Kenneth
	{ speaker: "player", char: 0, text: "Uh oh, here it comes..."}, //Milan
	{ speaker: "player", char: 1, text: "Everyone, get ready..."}, //Andrei
];

post_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "Phew... that was exhausting" }, //Milan
    { speaker: "player", char: 1, text: "Good thing we defeated it." }, //Andrei
	{ speaker: "player", char: 2, text: "Kenneth, what were you thinking?" }, // Hannah
	{ speaker: "player", char: 3, text: "I.. I'm sorry. I didn't mean to." }, // Kenneth
	{ speaker: "player", char: 2, text: "Just focus next time, okay?" }, // Hannah
	{ speaker: "player", char: 4, text: "We can't afford anymore mistakes." } // Jobelle
];
