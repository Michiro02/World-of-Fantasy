if (global.warringtriadDefeated) {
    instance_destroy();  
    exit;
}



escapeDelay = 0;
dead = false;

image_xscale = 0.4;
image_yscale = 0.4;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Warring Triad";

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences

initial_dialogue_sequence = [
    { speaker: "player", char: 0, text: "What is this thing?" }, //Milan
    { speaker: "player", char: 1, text: "Let's go to the town and ask\nif anyone knows." } // Andrei
];

battle_dialogue_sequence = [
    { speaker: "player", char: 1, text: "So this is the Warring Triad...", music: snd_Suspense}, // Andrei
    { speaker: "player", char: 2, text: "The air feels heavy... I can\nbarely breathe." }, // Hannah
    { speaker: "player", char: 3, text: "It's like something is watching\nus." }, // Kenneth
    { speaker: "player", char: 4, text: "No... it's worse. It's like\nthey're judging us." }, // Jobelle
    { speaker: "player", char: 1, text: "Their power... it's overwhelming.\nEven more than Gigatoa's." }, // Andrei
    { speaker: "player", char: 0, text: "We thought Gigatoa was the end,\nbut this... this is something else." }, // Milan
    { speaker: "player", char: 2, text: "If we could take down Gigatoa,\nwe can do this too. We have to." }, // Hannah
    { speaker: "player", char: 3, text: "They're not just testing our\nstrength... They're testing our will to\nfight." }, // Kenneth
    { speaker: "player", char: 4, text: "Then we prove ourselves. No more\nholding back!" }, // Jobelle
    { speaker: "player", char: 1, text: "If we fall here, Eldoria falls\nwith us." }, // Andrei
    { speaker: "player", char: 0, text: "We've overcome the darkness\nbefore. We'll do it again! No matter how\nstrong they are, we won't back down!" }, // Milan
	{ speaker: "player", char: 3, text: "We end this. Once and for all!" }, // Kenneth
	{ speaker: "player", char: 4, text: "Then let's show them the\nstrength of everything we've fought for!" }, // Jobelle
    { speaker: "player", char: 0, text: "Be ready, everyone! It's coming to\nlife!" }, // Milan
	{ speaker: "player", char: 1, text: "W-Wait... what's happening?!"}, // Andrei
    { speaker: "player", char: 2, text: "They're... they're merging?!" }, // Hannah
    { speaker: "player", char: 3, text: "Impossible... their energy is\nfusing into something even stronger!" }, // Kenneth
    { speaker: "player", char: 4, text: "No way... this power... it's\nshaking the whole battlefield!" }, // Jobelle
    { speaker: "player", char: 0, text: "Everyone, brace yourselves!" } // Milan
];


post_battle_dialogue_sequence = [
    { speaker: "player", char: 1, text: "It's over... we actually did it." }, // Andrei  
    { speaker: "player", char: 2, text: "Their power is gone... the world\nis safe." }, // Hannah  
    { speaker: "player", char: 3, text: "That was the toughest battle of\nour lives..." }, // Kenneth  
    { speaker: "player", char: 4, text: "But we stood together. And we\nwon." }, // Jobelle  
    { speaker: "player", char: 0, text: "The Warring Triad is no more...\nand peace can finally return." }, // Milan  
    { speaker: "player", char: 1, text: "The land may bear the scars of\nbattle, but life will go on." }, // Andrei  
    { speaker: "player", char: 3, text: "And we made sure it stays that\nway." }, // Kenneth
    { speaker: "player", char: 2, text: "We should head back and tell\nThalor that it's finally over." }, // Hannah  
    { speaker: "player", char: 0, text: "Let's go. Whatever comes next...\nwe'll face it together." }, // Milan  
    { speaker: "player", char: 4, text: "Wait... something's here!" }, // Jobelle  
    { speaker: "player", char: 2, text: "A weapon? Did the Warring Triad\ndrop this?" }, // Hannah  
    { speaker: "player", char: 0, text: "Let's check it out. This might be\nmore than just any weapon." } // Milan  
];


// Use the initial dialogue by default
dialogue_sequence = initial_dialogue_sequence;

dialogue_cooldown = 0; // Cooldown timer to prevent immediate retriggering
cooldown_duration = 180; // Cooldown duration in frames (1 second at 60 FPS)