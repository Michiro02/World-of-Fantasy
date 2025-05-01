// Warp properties
targetRoom = -1;
targetX = 0;
targetY = 0;
warpState = 0; // 0 = idle, 1 = loading, 2 = waiting for dialogue
loadingTimer = 120;
loadingDuration = 120;
roomName = "";

// Dialogue properties
dialogue_visible = false;
dialogue_index = 0;
dialogue_range = 35;
npc_name = "System";

dialogue_sequence = [
    { speaker: "npc", text: "How to Play\n\n Use arrow keys or WASD to move\n Use enter to interact NPC or to Confirm." },
	{ speaker: "npc", text: "How to Play\n\n Use ESC to pause the game." },
	{ speaker: "npc", text: "In Battle\n\n Use arrow keys or WASD for selecting.\n Use Shift to target all." },
	{ speaker: "npc", text: "In Battle\n\n Use ESC to cancel your action or\n selection." },
	{ speaker: "npc", text: "Encounters\n\nWhile walking, battle may start at random.\nThe more you move, the higher the chance."},
	{ speaker: "npc", text: "Good luck, adventurer. We're\ncounting on you to save Eldoria." },

];