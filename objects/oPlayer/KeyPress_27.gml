// oPlayer Escape Key Press Event
if (keyboard_check_pressed(vk_escape)) {
    if (!global.dialogue_active && !instance_exists(oLoadingScreen)) { // Prevent pausing if a dialogue is active
        if (instance_exists(oPauseMenu)) {

            // Check if the confirmation dialog is active
            if (global.menu_state == "confirm_save" || global.menu_state == "confirm_load") {
                // Close the confirmation dialog by returning to the previous menu state
                global.menu_state = "main"; // Or set it to the state before the confirmation
                audio_play_sound(snd_Menu, 1, false);

            // Check if sub-menus are active and close them first
            } else if (global.show_controls || global.show_inventory) {
                global.show_controls = false;
                global.show_inventory = false;
                audio_play_sound(snd_Menu, 1, false);

            } else if (global.menu_state == "save_select" || global.menu_state == "load_select") {
                // Close the save/load slots and return to main menu
                global.menu_state = "main";
                audio_play_sound(snd_Menu, 1, false);
			} else if (global.menu_state == "equip_weapon" || global.menu_state == "equip_member") {
			  global.menu_state = "main";
			  audio_play_sound(snd_Menu, 1, false);

            } else {
                // Unpause the game by destroying the pause menu
                with (oPauseMenu) {
                    instance_destroy();
                    audio_play_sound(snd_Menu, 1, false);
                }
                global.game_paused = false;

                // Revert to the original viewport size
                camera_set_view_size(view_camera[0], global.original_viewport_width, global.original_viewport_height);
            }
        } else {
            // Pause the game by creating the pause menu
            instance_create_layer(x, y, "GUI", oPauseMenu);
            global.game_paused = true;
            audio_play_sound(snd_Menu, 1, false);

            // Save the original viewport size (only once)
            if (!variable_global_exists("original_viewport_width")) {
                global.original_viewport_width = camera_get_view_width(view_camera[0]);
                global.original_viewport_height = camera_get_view_height(view_camera[0]);
            }

            // Change the viewport size to 420x250
            camera_set_view_size(view_camera[0], 420, 300);
        }
    }
}
