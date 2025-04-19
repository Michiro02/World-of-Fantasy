// Step Event of oWarringTriad
escapeDelay = max(escapeDelay - 1, 0);

// Handle cooldown
if (dialogue_cooldown > 0) {
    dialogue_cooldown--;
}

if (dead) {
    if (!post_battle_dialogue_visible) {
        post_battle_dialogue_visible = true;
        global.dialogue_active = true;
        image_alpha -= 0.05;
       // image_blend = c_white;
        if (image_alpha <= 0) {
           // Check if any instances of oEnemy exist before deactivating them
            if (instance_exists(oWarringTriad)) {
                instance_deactivate_object(oWarringTriad);  
				
			}
        }
    }
}

if (dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false); // Play the sound when "F" is pressed
		
		
        dialogue_index += 1;
        if (dialogue_index >= array_length(dialogue_sequence)) {
            dialogue_visible = false;
            global.dialogue_active = false;
            dialogue_index = 0;

            // Start the battle only if the NPC dialogue has been completed
            if (global.npcDialogueComplete) {
                start_battle = true;
            }

            // Set the cooldown to prevent immediate retriggering
            dialogue_cooldown = cooldown_duration;
        }
    }
}

if (post_battle_dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false); // Play the sound when "F" is pressed

        post_battle_dialogue_index += 1;
        if (post_battle_dialogue_index >= array_length(post_battle_dialogue_sequence)) {
            post_battle_dialogue_visible = false;
            global.dialogue_active = false;
            post_battle_dialogue_index = 0;
            global.cerberusDefeated = true;

            // Add the Ultima to the player's inventory
            AddWeaponToInventory(global.weaponLibrary.UltimaSword, 1); 
            AddWeaponToInventory(global.weaponLibrary.UltimaStaff, 1);   
            AddWeaponToInventory(global.weaponLibrary.UltimaLance, 1); 
            AddWeaponToInventory(global.weaponLibrary.UltimaBook, 1); 
            AddWeaponToInventory(global.weaponLibrary.UltimaBow, 1); 
			
			 global.warringtriadDefeated = true;
			 global.newDialogue = true;
            instance_destroy();  // Finally destroy the enemy instance
        }
    }
}

if (start_battle) {
    // Hide dialogue box and reset variables
    dialogue_visible = false;
    global.dialogue_active = false;
    start_battle = false; // Reset the battle start flag to avoid repeated triggers

    // Start the battle here
    NewEncounter(
        choose(
            [global.enemies.demon],
        ),
        sBgTriad
    );
    audio_stop_all();
    audio_play_sound(snd_Phase1, 1, true);

    // Ensure the instance is destroyed after starting the battle
    // instance_destroy();  // Do not destroy here to handle post-battle dialogue
}