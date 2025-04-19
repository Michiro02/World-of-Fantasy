// Collision with oPlayer
if (warpState == 0) {
    // Store the room name and target coordinates
	  if (room == Weapon_Shop) {
	    roomName = "Town of Mekzidas";
	    targetRoom = Town_of_Mekzidas;
	    targetX = 183;
	    targetY = 189;

        // Disable player control
        oPlayer.canMove = false;  // Stop player movement

        // Switch to the loading state
        warpState = 1;
        loadingTimer = loadingDuration;  // Start the loading timer

        // Display the loading screen (remove room name display for now)
        instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
    }
}
