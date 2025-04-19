// Create event
dialogue_visible = false; // Controls if the dialogue is shown
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 28; // The range within which the dialogue is triggered

// Define the dog's name
npc_name = "Juza";

// Define the dialogue sequence for finding the dog
dialogue_sequence = [
	{ speaker: "npc", text: "Woof!" },
    { speaker: "player", char: 0, text: "I think this is the Amethyst's dog." },
	{ speaker: "player", char: 1, text: "I'm sure it is. Let's bring it\nback to her." }
];

// Flag to track if the dog has been found
dog_found = false;

// Flag to track if the dog should be non-interactive (at the NPC's position)
non_interactive = false;