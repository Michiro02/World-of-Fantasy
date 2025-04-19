// Step Event in oWarp
if (warpState == 1) {
    // Countdown the loading screen timer
    loadingTimer -= 1;

    if (loadingTimer <= 0) {
        // Timer finished, start the room transition
        TransitionStart(targetRoom, sqFadeOut, sqSlideInDiagonal);
        room_goto(targetRoom);

        // Move player to the target position in the new room
        oPlayer.x = targetX;
        oPlayer.y = targetY;

        // Destroy the loading screen (assuming there's only one)
        with (oLoadingScreen) {
            instance_destroy();
        }

        // Show the room name now that loading is done
        var display_instance = instance_create_layer(oPlayer.x, oPlayer.y - 64, "UI", oDisplayBox);
        display_instance.display = roomName;

        // Re-enable player control after the warp is done
        oPlayer.canMove = true;

        // Reset the warp state
        warpState = 0;
    }
}
