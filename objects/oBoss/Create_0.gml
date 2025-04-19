if (global.bossDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}


// Create Event of oBoss (or oEnemy)
escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Gigatoa"; // Set this to your enemy's actual name

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
	{ speaker: "player", char: 0, text: "So you're here all along Gigatoa." },
    { speaker: "enemy", text: "You've come far, but your\njourney ends here!" },
    { speaker: "player", char: 0, text: "We won't let you stop us!" }, //Milan
    { speaker: "enemy", text: "Prepare to meet your doom!" }
];

post_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "Is... is it finally over?" }, //Milan
    { speaker: "player", char: 1, text: "I think so. We did it. The world\nis safe." }, //Andrei
	{ speaker: "enemy", text: "Do you really think it would be\nso easy?" },
    { speaker: "player", char: 2, text: "No... it can't be." }, //Hannah
	{ speaker: "enemy", text: "I am beyond your comprehension.\nDefeat me if you can, but know this.\nI am eternal. Waiting... in the void." },
	{ speaker: "player", char: 3, text: "We have to stop him before he\nregains his strength." }, //Kenneth
	{ speaker: "player", char: 2, text: "But how? He's... he's gone." }, //Hannah
	{ speaker: "player", char: 0, text: "Look, there's a square object in\nthe middle. Let's try to step on it." }, //Milan
	{ speaker: "player", char: 0, text: "This might be our last battle. So\nI hope you guys are ready." }, //Milan
	{ speaker: "player", char: 2, text: "I'm ready. We've faced down\nimpossible odds before. This time won't\nbe any different." }, //Hannah
	{ speaker: "player", char: 1, text: "We've come too far to turn back\nnow. This is our moment to make history,\nto ensure our world has a future." }, //Andrei
	{ speaker: "player", char: 3, text: "Our fate was sealed the day we\nchose this path. Now, let's finish what\nwe started." }, //Kenneth
	{ speaker: "player", char: 4, text: "Whatever comes next, we'll face\nit with courage. This ends here!" }, // Jobelle
];
