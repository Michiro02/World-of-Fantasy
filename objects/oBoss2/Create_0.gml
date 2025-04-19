// Create Event of oBoss (or oEnemy)
battle_stage = 0;  //  (0 = first battle, 1 = second battle)
escapeDelay = 0;
dead = false;

// Dialogue variables
dialogue_visible = false;
dialogue_index = 0;
start_battle = false;
enemy_name = "Gigatoa"; // Set this to your enemy's actual name

// Mid-battle dialogue variables
mid_battle_dialogue_visible = false;
mid_battle_dialogue_index = 0;

// Add this for post-battle dialogue
post_battle_dialogue_visible = false;
post_battle_dialogue_index = 0;

// Dialogue sequences
dialogue_sequence = [
	{ speaker: "player", char: 0, text: "This ends here, Gigatoa!!" }, //Milan
	{ speaker: "player", char: 1, text: "We won't let you threaten our\nworld any longer!" }, //Andrei
	{ speaker: "player", char: 2, text: "Prepare yourself. We're stronger\ntogether!" }, //Hannah
    { speaker: "enemy", text: "Fools... Did you think this form\nwas all I had? Behold, my true power!" },
    { speaker: "player", char: 3, text: "No... this can't be!" }, //Kenneth
	{ speaker: "player", char: 4, text: "How... how is this possible?" },
	{ speaker: "enemy", text: "You are but insects before me\nnow. Prepare to witness true despair!" },
];

mid_battle_dialogue_sequence = [
	{ speaker: "enemy", text: "Impressive... You were able to\npush me this far." },
	{ speaker: "player", char: 3, text: "You're not as invincible as\nyou thought, are you?" }, // Kenneth
	{ speaker: "player", char: 2, text: "This is for everyone you've\nhurt! We won't let you win!" }, // Hannah
	{ speaker: "enemy", text: "You think you can defeat me?\nI am the pinnacle of power!" },
	{ speaker: "player", char: 1, text: "Enough of your arrogance!\nYour reign ends here!" }, // Andrei
	{ speaker: "player", char: 4, text: "You're finished. We stand\ntogether, and you're out of time." }, // Jobelle
	{ speaker: "enemy", text: "No... this cannot be...\nI am unstoppable!" },
	{ speaker: "player", char: 0, text: "Then why are you falling back?\nFace it. You've lost." }, // Milan
    { speaker: "enemy", text: "Aghhh... How can this be\nhappening?!" },
	{ speaker: "player", char: 2, text: "Whoa... are we... floating?!" }, // Hannah
	{ speaker: "player", char: 1, text: "This... this place is unlike\nanything I've ever seen." }, // Andrei
	{ speaker: "player", char: 4, text: "The ground... it's like we're\nstanding on the edge of the universe\nitself." }, // Jobelle
	{ speaker: "enemy", text: "Surprised? This is my realm.\nHere, the laws of your world no longer\napply!" },
    { speaker: "player", char: 2, text: "Hold steady, everyone! This is\nwhere we show our strength!" }, // Hannah
    { speaker: "player", char: 0, text: "We've come too far to let fear\ntake over!" }, // Milan
    { speaker: "player", char: 1, text: "Right! No holding back. This\ntime, we end it for good!" }, // Andrei
    { speaker: "enemy", text: "You fools... you think this is\nthe end? My true power is limitless!" },
    { speaker: "player", char: 3, text: "Enough of your threats! We're\nstronger together, and you'll see just\nhow strong!" }, // Kenneth
    { speaker: "player", char: 2, text: "This fight isn't just for us...\nit's for everyone you've hurt." }, // Hannah
    { speaker: "player", char: 4, text: "Our friends, our families...\nthey're counting on us!" }, // Jobelle
    { speaker: "enemy", text: "Pathetic mortals! I will grind\nyour hopes to dust!" },
    { speaker: "player", char: 4, text: "Let's finish this, everyone.\nTogether, we're unstoppable!" }, // Jobelle
	{ speaker: "enemy", text: "Fools! You cannot comprehend the\npower I hold in this place!" },
	{ speaker: "player", char: 0, text: "Then let's see it! We'll fight\nyou, even here in the void!" }, // Milan
];


post_battle_dialogue_sequence = [
    { speaker: "player", char: 0, text: "It's... finally over. We did it." }, // Milan
    { speaker: "player", char: 1, text: "I can barely believe it. Gigatoa\nis defeated... for good." }, // Andrei
    { speaker: "player", char: 2, text: "The darkness feels... lighter\nsomehow, like the world can finally\nbreathe again." }, // Hannah
    { speaker: "enemy", text: "Heh... revel in your victory,\nmortals. But know this, true power leaves\nan echo. You may silence me, but you\ncannot erase what I have set in motion." },
    { speaker: "player", char: 3, text: "Your reign is over, Gigatoa.\nWhatever traces you've left behind, we'll\nbe there to cleanse them." }, // Kenneth
    { speaker: "player", char: 4, text: "Today, we proved that together,\nno shadow can endure our light." }, // Jobelle
    { speaker: "player", char: 0, text: "Let's return to the world we\nfought for. It's time to see the sunrise\non a new era." }, // Milan
    { speaker: "player", char: 1, text: "Yes. This victory is for\neveryone. We'll rebuild, stronger than\never before." }, // Andrei
];

