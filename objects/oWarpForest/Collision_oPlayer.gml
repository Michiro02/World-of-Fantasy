if (warpState == 0) {
    // Store the room name and target coordinates based on current room
    if (room == Town_of_Mekzidas) {
        roomName = "Mushroom Forest";
        targetRoom = Mushroom_Forest;
        targetX = 174;
        targetY = 361;
    } else if (room == Mushroom_Forest) {
        roomName = "Town of Mekzidas";
        targetRoom = Town_of_Mekzidas;
        targetX = 262;
        targetY = 30;
    }

    // Disable player control
    oPlayer.canMove = false;  // Stop player movement

    // Switch to the loading state
    warpState = 1;
    loadingTimer = loadingDuration;  // Start the loading timer

    // Display the loading screen (remove room name display for now)
    instance_create_layer(0, 0, "UI", oLoadingScreen);  // Assuming oLoadingScreen is your loading screen object
}
