if (warpState == 0) {
    // Store the room name and target coordinates based on current room
	   if (room == Desert) {
	    roomName = "  Pyramid";
	    targetRoom = Pyramid;
	    targetX = 231;
	    targetY = 361;
	} else if (room == Pyramid) {
	    roomName = "   Desert";
	    targetRoom = Desert;
	    targetX = 359;
	    targetY = 112; 
	}


    // Disable player control
    oPlayer.canMove = false;  // Stop player movement

    // Switch to the loading state
    warpState = 1;
    loadingTimer = loadingDuration;  // Start the loading timer

    // Display the loading screen (remove room name display for now)
    instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
}
