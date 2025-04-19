dialogue_visible = false; // Controls if the dialogue is shown
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 20; // The range within which the dialogue is triggered


image_xscale = 0.7;
image_yscale = 0.7;

// Define the NPC's name
npc_name = "Thalor";
if (!global.newDialogue) {
    dialogue_sequence = [
        { speaker: "player", char: 0, text: "Hello, can we ask if you know the\nstatues in the desert?" },
        { speaker: "npc", text: "I see you've encountered the\nstatues in the desert." },
        { speaker: "player", char: 0, text: "Yes, they're massive and...\nunsettling." }, // Milan
        { speaker: "npc", text: "Unsettling is an understatement.\nThose statues are tied to an ancient\nlegend." },
        { speaker: "player", char: 1, text: "What kind of legend?" }, // Andrei
        { speaker: "npc", text: "They're said to be the seals of\nthe Warring Triad, three deities who\nnearly destroyed the world." },
        { speaker: "player", char: 2, text: "Deities? You mean like gods?" }, // Hannah
        { speaker: "npc", text: "Not just any gods. Beings of\nimmense power, sealed away long ago by\nheroes of old." },
        { speaker: "player", char: 3, text: "And now they're waking up?" }, // Kenneth
        { speaker: "npc", text: "It seems so. The defeat of Gigatoa\nmay have disrupted the balance." },
        { speaker: "npc", text: "If the Triad awakens, the\nconsequences could be catastrophic." },
        { speaker: "player", char: 4, text: "We'll try to stop them. Any\nadvice?" }, // Jobelle
        { speaker: "npc", text: "Be prepared. The Triad's power is\nbeyond anything you've faced." },
        { speaker: "npc", text: "Take supplies and don't\nunderestimate them." },
        { speaker: "npc", text: "And one more thing... there's a\nchance the Exarch may appear." },
        { speaker: "player", char: 1, text: "Exarch? Who or what is that?" }, // Andrei
        { speaker: "npc", text: "The highest rank among them. The\none who ruled over the others." },
        { speaker: "npc", text: "Legends say the Exarch only\nmanifests when the Warring Triad is in\ndanger... and you've certainly become a\nthreat to them." },
        { speaker: "player", char: 2, text: "So if we defeat the three\ndeities... there's a chance the Exarch\nwill awaken?" }, // Hannah
        { speaker: "npc", text: "Yes. And if that happens... you\nwill be facing a power beyond mortal\ncomprehension." },
        { speaker: "npc", text: "Good luck. The fate of the world\nmay depend on your actions." }
    ];
} else {
    dialogue_sequence = [
        { speaker: "npc", text: "You... you really did it." },
        { speaker: "player", char: 0, text: "The Warring Triad is no more. The\ngods are gone." },
        { speaker: "npc", text: "For the first time in history,\nwe are truly free." },
        { speaker: "player", char: 1, text: "It wasn't easy. We nearly lost\neverything." },
        { speaker: "npc", text: "And yet, you prevailed. The world\nowes you a debt that can never be\nrepaid." },
        { speaker: "npc", text: "Legends will be told of this day,\nfor all eternity." },
        { speaker: "player", char: 2, text: "What happens now?" },
        { speaker: "npc", text: "Now, you rest. And the world\nmoves forward-on its own, free from\nthe shadows of the past." },
        { speaker: "player", char: 3, text: "Maybe it's time we moved on too." },
        { speaker: "npc", text: "Go, heroes. You've earned it." },
        { speaker: "npc", text: "Thank you... for everything." },
        { speaker: "player", char: 4, text: "Goodbye, Thalor." },
        { speaker: "npc", text: "Farewell, travelers." },
    ];
}
