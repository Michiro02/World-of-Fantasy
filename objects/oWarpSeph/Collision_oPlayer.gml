if (warpState == 0) {
    // Store the room name and target coordinates based on current room
	  if (room == Mushroom_Forest) {
	    roomName = "Unknown Town";
	    targetRoom = Sephiroth_Map;
	    targetX = 31;
	    targetY = 246;
	} else if (room == Sephiroth_Map) {
	    roomName = "Mushroom Forest";
	    targetRoom = Mushroom_Forest;
	    targetX = 492;
	    targetY = 380; 
	}


    // Disable player control
    oPlayer.canMove = false;  // Stop player movement

    // Switch to the loading state
    warpState = 1;
    loadingTimer = loadingDuration;  // Start the loading timer

    // Display the loading screen (remove room name display for now)
    instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
}
