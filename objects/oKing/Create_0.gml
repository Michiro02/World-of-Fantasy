// Create Event
dialogue_visible = true;  // Start with the dialogue visible immediately
dialogue_index = 0;       // Start with the first dialogue
dialogue_range = 35;      // The range within which the dialogue is triggered
initial_dialogue_completed = false;  // Flag to check if the initial dialogue is completed

// Define the NPC's name
npc_name = "King Baron";


dialogue_sequence = [
    { speaker: "npc", text: "Adventurers... you arrived at\na perilous time. The land of Eldoria is on\nthe brink of a great darkness." },
    { speaker: "player", char: 0, text: "We've heard rumors. Something\nstirs, an ancient power, is that true?" }, // Milan
    { speaker: "npc", text: "Indeed. The ancient evil,\nGigatoa, begins to awaken once more,\ncasting its shadow all over that lives." },
    { speaker: "player", char: 1, text: "We thought Gigatoa was sealed\nafter the Great Cataclysm. How could\nthis happen?" }, // Andrei
    { speaker: "npc", text: "The seal weakens, and with it,\ndark creatures have begun to roam,\ncorrupting the land."},
	{ speaker: "npc", text: "The ruins of old stir with\nmalevolent energy."},
    { speaker: "player", char: 2, text: "If Gigatoa truly returned, it\ncould mean the end of everything!" }, // Hannah
    { speaker: "player", char: 3, text: "Tell us what we need to do.\nWe won't let this world fall." }, // Kenneth
    { speaker: "npc", text: "Your path lies beyond the city\nthrough the ancient forest and into the\ndesert. There, the remnants of the past\nspeak." },
    { speaker: "npc", text: "But be warned. Many\nadventurers have gone seeking the source\nof the darkness. Few have returned." },
    { speaker: "npc", text: "Go to the portal there, and\nyou will be teleported in the field.\nIt will lead you closer to Gigatoa's lair.\nSeek it out and step through." },
		{ speaker: "player", char: 4, text: "Let's go, I hope that Gigatoa is\nstill weak if we go there." }, // Jobelle
    { speaker: "npc", text: "Gather your strength for your\njourney is fraught with peril. And the\nfate of Eldoria hangs by a thread." }
];


repeat_dialogue = [{ speaker: "npc", text: "May the light guide you on\nyour journey, brave souls. The portal will\ntake you closer to Gigatoa's lair." }];