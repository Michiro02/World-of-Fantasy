// Create event
dialogue_visible = false; // Controls if the dialogue is shown
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 28; // The range within which the dialogue is triggered

// Define the NPC's name
npc_name = "Amethyst";

// Define the initial dialogue sequence
dialogue_sequence = [
    { speaker: "npc", text: "Have you seen my dog? His name\nis Juza." }
];

// Flag to track if the dog has been found
dog_found = false;

// Reference to the dog instance at the NPC's position
npc_dog_instance = noone;
