// Handle fade effect (example for menu fade-in/out)
alpha += fade_speed;

if (alpha >= 1 && global.menu_state == "none") {
    // Trigger the confirmation dialog after the fade-out
    global.menu_state = "confirm_save";  // Show the confirmation dialog
}

// Handle the confirmation dialog
if (global.menu_state == "confirm_save") {
    // Toggle between "Yes" and "No" with left/right or A/D keys
    if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_confirmation = (global.selected_confirmation == 1) ? 0 : 1;
    }

    if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_confirmation = (global.selected_confirmation == 1) ? 0 : 1;
    }

    // Handle Enter key to confirm the choice (save or cancel)
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        if (global.selected_confirmation == 1) {  // If "Yes" is selected
            global.menu_state = "save_select"; // Go to save slot selection state
        } else {  // If "No" is selected
            scr_reset_globals();
			game_restart(); 
        }
    }

    // Handle Escape key to return to the main menu
    if (keyboard_check_pressed(vk_escape)) {
        global.menu_state = "none";  // Return to the main menu
		audio_play_sound(snd_Menu,1,false);
    }
}

// Slot selection for save/load
else if (global.menu_state == "save_select") {
    // Navigate between save slots with up/down or W/S keys
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_slot -= 1;
        if (global.selected_slot < 1) {
            global.selected_slot = 3; // Wrap around to last slot
        }
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_slot += 1;
        if (global.selected_slot > 3) {
            global.selected_slot = 1; // Wrap around to first slot
        }
    }

    // Handle Enter key to confirm save
    if (keyboard_check_pressed(vk_enter)) {
        var slot_filename = "savegame" + string(global.selected_slot) + ".txt";
        // Save the game to the selected slot
        scr_save_game(global.selected_slot, true); // Save to the selected slot
		var msg_box = instance_create_layer(x + 70, y, "UI", oMessageBox_1);
        msg_box.message = "You save your game in slot " + string(global.selected_slot);

        global.menu_state = "none";
        audio_play_sound(snd_Menu, 1, false);
		
    }

    // Handle Escape key to return to the confirmation dialog
    if (keyboard_check_pressed(vk_escape)) {
        global.menu_state = "confirm_save"; // Go back to the confirmation state
		audio_play_sound(snd_Menu,1,false);
    }
}
