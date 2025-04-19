if (global.sephirothDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}
battle_stage = 0; 
escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Sephiroth"; // Set this to your enemy's actual name

// Choice handling variables
awaiting_choice = false;  // New variable to track if a choice is active
selected_choice = 0;  // 0 = "Yes", 1 = "No" (default starts on "Yes")
player_choice = -1;  // -1 = no choice made, 0 = No, 1 = Yes
peaceful_exit = false;

// Mid-battle dialogue variables
mid_battle_dialogue_visible = false;
mid_battle_dialogue_index = 0;

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
	{ speaker: "player", char: 0, text: "Who are you? What do you want\nhere?" }, //Milan
    { speaker: "enemy", text: "I am Sephiroth, and I seek...\nWhere am I?" },
    { speaker: "player", char: 3, text: "You're in a different world,\nSephiroth. One you shouldn't have\ncrossed into." }, //Kenneth
    { speaker: "enemy", text: "Different world? What nonsense\nis this? This place... it's not where I\nwas." },
	{ speaker: "player", char: 2, text: "It doesn't matter where you were.\nYou're not welcome here." }, //Hannah
	{ speaker: "player", char: 1, text: "We can't let him roam freely.\nWho knows what havoc he could cause?" }, //Andrei
	{ speaker: "player", char: 0, text: "We'll stop you, Sephiroth, whatever\nit takes." }, //Milan
	{ speaker: "enemy", text: "Very well. Let's see if your\nstrength matches your bravado." },
];

original_dialogue_sequence = dialogue_sequence;

mid_battle_dialogue_sequence = [
    { speaker: "enemy", text: "Is this... all you have?\nHow... disappointing." },
    { speaker: "player", char: 1, text: "You're tougher than I thought,\nSephiroth, but you won't win!" }, // Andrei
    { speaker: "enemy", text: "You think you've beaten me?\nWatch closely as I ascend!" },
    { speaker: "player", char: 3, text: "What's happening?!" }, // Kenneth
    { speaker: "enemy", text: "I have cast aside my mortal\nconstraints. This is my true form!" },
    { speaker: "player", char: 0, text: "A wing... Is he... evolving?" }, // Milan
    { speaker: "player", char: 4, text: "We need to stop him now! Before\nhe becomes unstoppable!" }, // Jobelle
    { speaker: "player", char: 2, text: "Stay strong! We're not finished\nyet!" }, // Hannah
    { speaker: "player", char: 1, text: "We've come this far... there's no\nturning back now!" }, // Andrei
    { speaker: "enemy", text: "Your resistance is futile!\nThis world... will fall before me!" },
    { speaker: "player", char: 0, text: "Not while we're still standing!" }, // Milan
    { speaker: "player", char: 3, text: "We can't let up, no matter how\nmuch power he's gained!" }, // Kenneth
	 { speaker: "enemy", text: "Now... witness the true\nstrength of my power!" },
];


post_battle_dialogue_sequence = [
    { speaker: "enemy", text: "Impossible... I was supposed\nto be... invincible..." },
    { speaker: "player", char: 2, text: "We've defeated you, Sephiroth.\nYou're finished!" }, // Hannah
    { speaker: "enemy", text: "You think this is the end? You\nknow nothing of the forces that I\ncontrol!" },
    { speaker: "player", char: 3, text: "No more words, Sephiroth. It's\nover." }, // Kenneth
    { speaker: "player", char: 1, text: "We've stopped you here, but how\nmany more worlds have you ravaged?" }, // Andrei
    { speaker: "player", char: 0, text: "We need to make sure you can't\nhurt anyone again. We need to find a way\nto seal you away." }, // Milan
    { speaker: "player", char: 4, text: "He's gone for now... but his\nwords... they still haunt me." }, // Jobelle
    { speaker: "player", char: 2, text: "I can feel it too. He's not\nsomeone who gives up easily. We have to\nbe ready." }, // Hannah
    { speaker: "player", char: 1, text: "We won today. Let's take a moment\nto recover. We've earned it." }, // Andrei
    { speaker: "player", char: 3, text: "Rest, but stay alert. We don't\nknow what Sephiroth is truly capable of." }, // Kenneth
    { speaker: "player", char: 0, text: "For now, we take the victory...\nbut we prepare for what may come next." }, // Milan
];


no_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "We may not be ready, but that\nwon't stop us from standing in your way." },
    { speaker: "enemy", text: "Not ready? How quaint. You\nthink merely existing here makes you\nworthy? You're nothing but shadows." },
    { speaker: "enemy", text: "Run along, little warriors.\nWhen you find the courage to confront\ntrue power, perhaps, I'll entertain your\nfutile attempts." },
];


