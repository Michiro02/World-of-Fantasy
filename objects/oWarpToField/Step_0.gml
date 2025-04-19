// Step Event
switch (warpState) {
    case 0: // Idle state - waiting for collision
        break;
        
    case 1: // Loading state - countdown before warp
        loadingTimer -= 1;
        if (loadingTimer <= 0) {
            TransitionStart(targetRoom, sqFadeOut, sqSlideInDiagonal);
            room_goto(targetRoom);
            oPlayer.x = targetX;
            oPlayer.y = targetY;
            
            with (oLoadingScreen) instance_destroy();
            
            var display_instance = instance_create_layer(oPlayer.x, oPlayer.y - 64, "UI", oDisplayBox);
            display_instance.display = roomName;
            
            oPlayer.canMove = true;
            warpState = 0;
        }
        break;
        
    case 2: // Waiting for dialogue to complete
        // Handle dialogue progression with Enter key
        if (keyboard_check_pressed(vk_enter) && dialogue_visible) {
            audio_play_sound(snd_Menu, 1, false);
            dialogue_index += 1;
            
            if (dialogue_index >= array_length(dialogue_sequence)) {
                // Dialogue finished, proceed with warp
                dialogue_visible = false;
                global.dialogue_active = false;
                warpState = 1;
                loadingTimer = loadingDuration;
                instance_create_layer(0, 0, "UI", oLoadingScreen);
            }
        }
        break;
}
