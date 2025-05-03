// NPC Variables
dialogue_visible = false; // Controls if the dialogue is shown
dialogue_state = 0; // Tracks the dialogue state (0 = greeting, 1 = shop menu, 2 = quantity selection)
dialogue_index = 0; // Index to track the current dialogue
dialogue_range = 40; // The range within which the dialogue is triggered

npc_name = "Miyuki";

// Define the weapons for sale and their prices
weapons_for_sale = [
	{ weapon: global.weaponLibrary.greatSword, price: 100 },
	{ weapon: global.weaponLibrary.masamune, price: 1000 },
    { weapon: global.weaponLibrary.ExSword, price: 100000 },
	{ weapon: global.weaponLibrary.lance, price: 1000},
    { weapon: global.weaponLibrary.staff, price: 500 },
	{ weapon: global.weaponLibrary.book, price: 500 },
	{ weapon: global.weaponLibrary.LongBow, price: 500 },
	{ weapon: global.weaponLibrary.DeathBow, price: 1000 },
	{ weapon: global.weaponLibrary.SageStaff, price: 1000 },
	{ weapon: global.weaponLibrary.Arcanist, price: 1000 },
	{ weapon: global.weaponLibrary.Everblade, price: 2000 },
	{ weapon: global.weaponLibrary.CrimsonHunt, price: 2000 },
	{ weapon: global.weaponLibrary.Whisperbane, price: 2000 },
	{ weapon: global.weaponLibrary.WindstriderLongbow, price: 2000 },
	{ weapon: global.weaponLibrary.Starseer, price: 2000 },
	{ weapon: global.weaponLibrary.Dusksorrow, price: 2500 },
	{ weapon: global.weaponLibrary.Lunareth, price: 2500 },
	{ weapon: global.weaponLibrary.Drakenspine, price: 2500 },
	{ weapon: global.weaponLibrary.Dusktome, price: 2500 },
	{ weapon: global.weaponLibrary.Sylverthorn, price: 2500 }
];

// Dialogue sequences
dialogue_sequence = [
    { speaker: "npc", text: "Welcome to my shop! What weapons\nwould you like to buy?"}
];

// Selection indices
selected_weapon_index = 0;
selected_quantity = 1; // Default quantity
cancel_selection = false; // Default cancel selection state

scroll_offset = 0; // Tracks how far down the list the player has scrolled
max_visible_items = 5; // Number of items visible at once