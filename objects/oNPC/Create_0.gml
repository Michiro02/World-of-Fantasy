dialogue_visible = false; // Controls if the dialogue is shown
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 20; // The range within which the dialogue is triggered

// Define the NPC's name
npc_name = "Tressa";

// Define the dialogue sequence
dialogue_sequence = [
    { speaker: "npc", text: "Welcome to our town, adventurers!\nWhat brings you here?" },
    { speaker: "player", char: 0, text: "We're looking for information." }, // Milan
    { speaker: "npc", text: "What kind of information are you\nseeking?" },
    { speaker: "player", char: 1, text: "We heard there are strong monsters\nappearing around here lately. We want to\ndefeat them to grow stronger and face the\nancient evil." }, // Andrei
    { speaker: "player", char: 1, text: "Do you know anything about these\ncreatures that might help us?" }, // Andrei
    { speaker: "npc", text: "Only whispers... but they say\nthere are two creatures unlike any\nyou've faced. They are called Bahamut\nand Leviathan."},
    { speaker: "player", char: 2, text: "Sounds like a challenge we're\nready for! Let's take them down!" }, // Hannah
    { speaker: "npc", text: "Wait! It's not just about\ndefeating them. There's more. It's said\nthat those with a special power can bind\nthese creatures to their will." },
    { speaker: "player", char: 3, text: "Binding them? You mean...\nsummoning?" }, // Kenneth
    { speaker: "npc", text: "Yes. If you defeat them, Kenneth,\nyou may be able to summon these two\ncreatures. Just like the legendary\nsummoners of old." },
    { speaker: "player", char: 3, text: "I already have Shiva and Ifrit.\nIf we can beat these two, they'll be a\ngreat addition." }, // Kenneth
    { speaker: "npc", text: "Be careful. Many have tried to\nconquer Bahamut and Leviathan, but\nnone returned." },
	{ speaker: "npc", text: "Head to the field to face Bahamut." },
	{ speaker: "npc", text: "Go east in this town to find\nLeviathan." },
	{ speaker: "player", char: 4, text: "Thank you Tressa for the\ninformation." }, //Jobelle
    { speaker: "npc", text: "I wish you luck. Summoning such\npowerful beasts will be no small task." }
];

