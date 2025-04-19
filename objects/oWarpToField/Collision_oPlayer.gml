if (warpState == 0) {
    if (room == Castle) {
        roomName = "   Field";
        targetRoom = Field;
        targetX = 222;
        targetY = 210;
        
        oPlayer.canMove = false;
        
        // Start dialogue
        dialogue_visible = true;
        global.dialogue_active = true;
        dialogue_index = 0;
        warpState = 2; // Set to waiting for dialogue state
    }
}
