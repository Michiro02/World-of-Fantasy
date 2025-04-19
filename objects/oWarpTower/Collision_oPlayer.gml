if (warpState == 0) {
    // Store the room name and target coordinates based on current room
	if (room == Desert) {
	    roomName = "   Tower";
	    targetRoom = Tower;
	    targetX = 230;
	    targetY = 376;
	} else if (room == Tower) {
	    roomName = "   Desert";
	    targetRoom = Desert;
	    targetX = 231;
	    targetY = 175; 
	}


    // Disable player control
    oPlayer.canMove = false;  // Stop player movement

    // Switch to the loading state
    warpState = 1;
    loadingTimer = loadingDuration;  // Start the loading timer

    // Display the loading screen (remove room name display for now)
    instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
}
