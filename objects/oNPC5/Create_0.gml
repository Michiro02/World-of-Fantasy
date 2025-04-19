// NPC Variables
dialogue_visible = false; // Controls if the dialogue is shown
dialogue_state = 0; // Tracks the dialogue state (0 = greeting, 1 = shop menu, 2 = quantity selection)
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 40; // The range within which the dialogue is triggered

npc_name = "Miyuki";

// Define the items for sale and their prices
items_for_sale = [
    { item: global.actionLibrary.potion, price: 50 },
    { item: global.actionLibrary.ether, price: 100 },
    { item: global.actionLibrary.elixir, price: 500 },
    { item: global.actionLibrary.revive, price: 200 },
	{ item: global.actionLibrary.Remedy, price: 600 },
    { item: global.actionLibrary.HighPotion, price: 1000 },
    { item: global.actionLibrary.HighElixir, price: 1500 },
    { item: global.actionLibrary.HighEther, price: 1250 },
	{ item: global.actionLibrary.XEther, price: 2050 },
	{ item: global.actionLibrary.XPotion, price: 2050 },
];

// Dialogue sequences
dialogue_sequence = [
    { speaker: "npc", text: "Welcome to my inn! What do you\nwant to buy?"}
];

// Selection indices
selected_item_index = 0;
selected_quantity = 1; // Default quantity
cancel_selection = false; // Default cancel selection state

scroll_offset = 0; // Tracks how far down the list the player has scrolled
max_visible_items = 5; // Number of items visible at once