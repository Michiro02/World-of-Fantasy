if (global.fourfiendsDefeated) {
    instance_destroy();  // Destroy the instance if the boss has already been defeated
    exit;
}

escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Four Fiends"; // Set this to your enemy's actual name

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
	{ speaker: "Miglione", text: "You dare approach, mortals?\nI shall grind you to dust beneath\nthe weight of the earth!" },
	{ speaker: "player", char: 0, text: "This ends now. We've fought too\nhard and lost too much to be stopped now!" }, // Milan
	{ speaker: "Barbariccia", text: "Hmph. Do you think we would\nstand by idly while you seek to harm\nour master, Gigatoa?" },
	{ speaker: "player", char: 2, text: "Gigatoa must be stopped! He's\ndestroyed countless lives. We won't\nlet you protect him!" }, // Hannah
	{ speaker: "Cagnazzo", text: "Foolish adventurers. Your\ninsignificant resistance will drown\nin a sea of despair!" },
	{ speaker: "player", char: 3, text: "We've come too far to let you\nstop us now! Get out of our way!" }, // Kenneth
	{ speaker: "Rubicante", text: "You cannot hope to match the\npower of the Four Fiends. We are the\neternal guardians of Gigatoa!" },
	{ speaker: "player", char: 1, text: "Guardians or not, you'll fall\nlike all the others who stood against\nus!" }, // Andrei
	{ speaker: "Miglione", text: "Brave words for mortals who\nstand on the edge of annihilation.\nYour bones will litter this battlefield!" },
	{ speaker: "Barbariccia", text: "Enough talk! Words mean\nnothing on the battlefield. Let us end\nthis once and for all!" },
	{ speaker: "player", char: 4, text: "Then come at us! We'll fight\nwith everything we have, to protect\nour world and everyone you've hurt!" }, // Jobelle

];

post_battle_dialogue_sequence = [
{ speaker: "Rubicante", text: "How... how can this be? The\npower of mortals cannot rival ours!" },
{ speaker: "Cagnazzo", text: "No... Gigatoa, forgive us!" },
{ speaker: "Miglione", text: "This isn't over. We'll rise\nagain... to end you!" },
{ speaker: "Barbariccia", text: "You may have won this battle,\nbut the war is far from over!" },
{ speaker: "player", char: 0, text: "We did it... but they'll be back.\nGigatoa's power isn't done with us yet." }, // Milan
{ speaker: "player", char: 4, text: "Then we move quickly. Gigatoa\nmust fall before they can recover." }, // Jobelle
{ speaker: "player", char: 1, text: "Agreed. Let's finish this. For\neveryone counting on us." }, // Andrei
];
