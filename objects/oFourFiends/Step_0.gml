//step
escapeDelay = max(escapeDelay - 1, 0);

if (dead) {
	 if (!post_battle_dialogue_visible) {
     post_battle_dialogue_visible = true;
     global.dialogue_active = true;
    image_alpha -= 0.05;
    image_blend = c_red;
    if (image_alpha <= 0) {
            // Check if any instances of oEnemy exist before deactivating them
            if (instance_exists(oFourFiends)) {
                instance_deactivate_object(oFourFiends);  // Deactivate the enemy object so it doesn't interfere with the dialogue
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
            start_battle = true;
            dialogue_index = 0;
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
			global.fourfiendsDefeated = true;
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
            [global.enemies.rubicante, global.enemies.cagnazzo, global.enemies.miglione, global.enemies.barbariccia],
        ),
        sBgNewBossFinal
    );
	audio_stop_all();
    audio_play_sound(snd_FourFiends, 1, true);
    audio_stop_sound(snd_GigaLair);
    audio_stop_sound(snd_Desert);

    // Ensure the instance is destroyed after starting the battle
    // instance_destroy();  // Do not destroy here to handle post-battle dialogue
}