if (warpState == 0) {
    // Store the room name and target coordinates based on current room
	  if (room == Mushroom_Forest) {
	    roomName = "   Desert";
	    targetRoom = Desert;
	    targetX = 240;
	    targetY = 368;
	} else if (room == Desert) {
	    roomName = "Mushroom Forest";
	    targetRoom = Mushroom_Forest;
	    targetX = 174;
	    targetY = 27; 
	}


    // Disable player control
    oPlayer.canMove = false;  // Stop player movement

    // Switch to the loading state
    warpState = 1;
    loadingTimer = loadingDuration;  // Start the loading timer

    // Display the loading screen (remove room name display for now)
    instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
}
