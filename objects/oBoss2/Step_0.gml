escapeDelay = max(escapeDelay - 1, 0);

if (dead) {
    if (battle_stage == 0 && !mid_battle_dialogue_visible) {
        // First phase is over, show mid-battle dialogue before second phase
        mid_battle_dialogue_visible = true;
        global.dialogue_active = true;
        image_alpha -= 0.05;
        image_blend = c_red;
        
        if (image_alpha <= 0 && instance_exists(oBoss2)) {
            instance_deactivate_object(oBoss2); // Deactivate oBoss2 if it exists
        }
    }
    else if (battle_stage == 1 && !post_battle_dialogue_visible) {
        // Second phase is over, show post-battle dialogue
        post_battle_dialogue_visible = true;
        global.dialogue_active = true;
    }
}

if (dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        
        // Play specific sound for a particular dialogue index
        if (dialogue_index == 2) {
            audio_play_sound(snd_BossLaugh, 1, false);
        }
        
        if (dialogue_index > 2) {
            audio_stop_sound(snd_BossLaugh);
        }
        
        dialogue_index += 1;
        if (dialogue_index >= array_length(dialogue_sequence)) {
            dialogue_visible = false;
            global.dialogue_active = false;
            start_battle = true;
            dialogue_index = 0;
        }
    }
}

if (mid_battle_dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        
		 // Play specific sound for a particular dialogue index
        if (mid_battle_dialogue_index == 2) {
            audio_play_sound(snd_Giga3Dial2, 1, true);
			audio_stop_sound(snd_BossFinal);
        }
		
        mid_battle_dialogue_index += 1;
        if (mid_battle_dialogue_index >= array_length(mid_battle_dialogue_sequence)) {
            mid_battle_dialogue_visible = false;
            global.dialogue_active = false;
            mid_battle_dialogue_index = 0;
            battle_stage = 1;  // Move to the second battle
            start_battle = true;  // Trigger the second battle
        }
    }
}

if (post_battle_dialogue_visible) {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        
		 // Play specific sound for a particular dialogue index
        if (post_battle_dialogue_index == 0) {
            audio_play_sound(snd_Giga3Dial3, 1, true);
			audio_stop_sound(snd_BossFinal);
        }
		
        post_battle_dialogue_index += 1;
        if (post_battle_dialogue_index >= array_length(post_battle_dialogue_sequence)) {
            post_battle_dialogue_visible = false;
            global.dialogue_active = false;
            post_battle_dialogue_index = 0;
			
			// Mark Gigatoa as defeated
            global.gigatoaDefeated = true;

            instance_destroy();  // Destroy the object after the final battle and dialogue
        }
    }
}

if (start_battle) {
    // Hide dialogue box and reset variables
    dialogue_visible = false;
    global.dialogue_active = false;
    start_battle = false;


    if (battle_stage == 0) {
        // First battle setup
        NewEncounter(
            choose(
                [global.enemies.giga2], // First form of the boss
            ),
            sBgNewBossFinal
        );
        audio_play_sound(snd_FinBossPhase1, 1, true);
    } else if (battle_stage == 1) {
        // Second battle setup
        NewEncounter(
            choose(
                [global.enemies.giga3], // Second form of the boss
            ),
            sBgFinBossPhase2
        );
        audio_play_sound(snd_FinBossPhase2, 1, true);
    }

    audio_stop_sound(snd_BossFinal);
	audio_stop_sound(snd_Giga3Dial2);
}