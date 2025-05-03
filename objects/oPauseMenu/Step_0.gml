// Check for global.dialogue_active or menu state transitions
if (!global.dialogue_active) {

    // Main menu navigation
    if (global.menu_state == "main") {
        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_item -= 1;
            if (global.selected_item < 1) {
                global.selected_item = 7; // Increased for the new Equip option
            }
        }

        if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_item += 1;
            if (global.selected_item > 7) { // Increased for the new Equip option
                global.selected_item = 1;
            }
        }
		
		// Handle volume control
        if(global.selected_item == 7) { // Volume Option
            if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)){
                audio_play_sound(snd_Menu,1,false); // Play sound when adjusting
                global.volume = max(global.volume - 0.05,0); // Decrease volume, minimum 0
                audio_master_gain(global.volume);
            }
            
            if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)){
                audio_play_sound(snd_Menu,1,false); // Play sound when adjusting
                global.volume = min(global.volume + 0.05,1); // Increase volume, maximum 1
                audio_master_gain(global.volume);
            }
        }

        // Handle Enter key to select a menu option
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);
            switch (global.selected_item) {
                case 1:
                    global.selected_confirmation = 1; // Initialize to Yes
                    global.menu_state = "confirm_save";
                    break;
                case 2:
                    global.selected_confirmation = 1; // Initialize to Yes
                    global.menu_state = "confirm_load";
                    break;
                case 3:
                    global.show_inventory = true;
					global.show_controls = false;
                    global.menu_state = "inventory"; // Switch to inventory state
                    global.selected_item_index = 0; // Initialize item selection
                    break;
                case 4:
                    global.show_controls = true;
                    break;
                case 5:
                    global.show_equip = true;
					global.show_controls = false;
					global.show_inventory = false;
                    global.menu_state = "equip_weapon";
                    break;
                case 6:
                   // game_end();
					global.selected_confirmation = 1;
					global.menu_state = "confirm_quit";
					just_entered_confirmation = true;
                    break;
            }
        }
    }
	

    // Inventory navigation
    else if (global.menu_state == "inventory") {
        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_item_index -= 1;
            if (global.selected_item_index < 0) {
                global.selected_item_index = array_length(global.inventory) - 1;
            }
        }

        if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_item_index += 1;
            if (global.selected_item_index >= array_length(global.inventory)) {
                global.selected_item_index = 0;
            }
        }

        // Cancel and go back to main menu
        if (keyboard_check_pressed(vk_escape)) {
            global.show_inventory = false;
            global.menu_state = "main";
        }
    }

   // Equip menu: Choose weapon
else if (global.menu_state == "equip_weapon") {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_weapon_index -= 1;
        if (global.selected_weapon_index < 0) {
            global.selected_weapon_index = array_length(global.weaponInventory) - 1;
        }
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_weapon_index += 1;
        if (global.selected_weapon_index >= array_length(global.weaponInventory)) {
            global.selected_weapon_index = 0;
        }
    }

    // Confirm weapon selection to choose party member
    if (keyboard_check_pressed(vk_enter)) {
        if (array_length(global.weaponInventory) == 0 || global.selected_weapon_index >= array_length(global.weaponInventory)) {
            audio_play_sound(snd_Menu, 1, false);
            weapon_text = "No equipment";
        } else {
            audio_play_sound(snd_Menu, 1, false);
            global.menu_state = "equip_member";
        }
    }

    // Cancel and go back to main menu
    if (keyboard_check_pressed(vk_escape)) {
        global.show_equip = false;
        global.menu_state = "main";
    }
}

// Equip menu: Choose party member to equip weapon
// Equip menu: Choose party member to equip weapon
else if (global.menu_state == "equip_member") {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_party_member_index -= 1;
        if (global.selected_party_member_index < 0) {
            global.selected_party_member_index = array_length(global.party) - 1;
        }
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_Menu, 1, false);
        global.selected_party_member_index += 1;
        if (global.selected_party_member_index >= array_length(global.party)) {
            global.selected_party_member_index = 0;
        }
    }

    // Confirm party member selection and equip weapon
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);
        var weapon = global.weaponInventory[global.selected_weapon_index][0];
        var member = global.party[global.selected_party_member_index];

        // Check if the weapon is already equipped
        if (member.equippedWeapon == weapon) {
            weapon_text = "Already equipped";
        }
        // Check if the character can equip the selected weapon
        else if (!array_contains(member.allowedWeaponTypes, weapon.type)) {
            weapon_text = "Cannot equip this weapon";
        } else {
            // **Remove stats from the currently equipped weapon**
            if (member.equippedWeapon != undefined) {
                // Calculate the ratio of current HP/MP to max HP/MP before removing the weapon
                var hpRatio = member.hp / member.hpMax;
                var mpRatio = member.mp / member.mpMax;

                // Remove the weapon's bonuses
                member.strength -= member.equippedWeapon.strengthBonus;
                member.magic -= member.equippedWeapon.magicBonus;
                member.hpMax = member.baseHpMax; // Reset hpMax to baseHpMax
                member.mpMax = member.baseMpMax; // Reset mpMax to baseMpMax

                // Recalculate current HP/MP based on the new max values
                member.hp = floor(hpRatio * member.hpMax);
                member.mp = floor(mpRatio * member.mpMax);

                // Ensure HP/MP doesn't drop below 1
                member.hp = max(member.hp, 1);
                member.mp = max(member.mp, 1);

                // **Add the currently equipped weapon back to the inventory**
                AddWeaponToInventory(member.equippedWeapon, 1);
            }

            // **Equip new weapon and update stats**
            member.equippedWeapon = weapon;
            member.strength += weapon.strengthBonus;
            member.magic += weapon.magicBonus;
            member.hpMax = member.baseHpMax + weapon.hpBonus; // Update hpMax with weapon bonus
            member.mpMax = member.baseMpMax + weapon.mpBonus; // Update mpMax with weapon bonus

            // **Cap HP/MP at 9999**
            member.hpMax = min(member.hpMax, 9999);
            member.mpMax = min(member.mpMax, 9999);

            // **Refresh current HP/MP to match the new maximum**
            member.hp = member.hpMax;
            member.mp = member.mpMax;

            // **Remove the new weapon from inventory**
            RemoveWeaponFromInventory(weapon, 1);

            weapon_text = member.name + " equipped " + weapon.name + "!";

            // Reset menu state
            global.show_equip = false;
            global.menu_state = "main";
        }
    }

    // Cancel and go back to weapon selection
    if (keyboard_check_pressed(vk_escape)) {
        global.menu_state = "equip_weapon";
    }
}

    // Confirmation dialog for saving/loading
    else if (global.menu_state == "confirm_save" || global.menu_state == "confirm_load") {
        if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_confirmation = (global.selected_confirmation == 1) ? 0 : 1;
        }
        
        if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
            audio_play_sound(snd_Menu, 1, false);
            global.selected_confirmation = (global.selected_confirmation == 1) ? 0 : 1;
        }
        
        // Handle Enter key to confirm the choice
        if (keyboard_check_pressed(vk_enter)) {
			audio_play_sound(snd_Menu,1,false);
            if (global.selected_confirmation == 1) {  // If "Yes" is selected
                if (global.menu_state == "confirm_save") {
                    global.menu_state = "save_select";
                } else if (global.menu_state == "confirm_load") {
                    global.menu_state = "load_select";
                }
            } else {  // If "No" is selected
                global.menu_state = "main";
            }
        }
        
        // Handle Escape key to return to the main menu
        if (keyboard_check_pressed(vk_escape)) {
            global.menu_state = "main";
        }
	}

    // Slot selection for save/load
    else if (global.menu_state == "save_select" || global.menu_state == "load_select") {
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

        // Handle Enter key to confirm save/load
        if (keyboard_check_pressed(vk_enter)) {
            var slot_filename = "savegame" + string(global.selected_slot) + ".txt";
            if (global.menu_state == "save_select") {
                scr_save_game(global.selected_slot); // Save to the selected slot
                message_text = "Game Saved"; // Set the message text
            } else if (global.menu_state == "load_select") {
                if (file_exists(slot_filename)) {
                    scr_load_game(global.selected_slot); // Load from the selected slot
                    message_text = "Game Loaded"; // Set the message text
                } else {
                    message_text = "No save file "; // No file to load
                }
            }
            global.menu_state = "main"; // Return to the main menu after saving/loading
            audio_play_sound(snd_Menu, 1, false);
        }

        // Handle Escape key to return to the main menu
        if (keyboard_check_pressed(vk_escape)) {
            global.menu_state = "main";
        }
    }

// Display message if message_text is not empty
if (message_text != "") {
    var existing_msg_box = instance_exists(oMessageBox);
    var msg_box;
    
    if (existing_msg_box) {
        msg_box = instance_find(oMessageBox, 0);
        msg_box.message = message_text;
        msg_box.timer = 60;
    } else {
        msg_box = instance_create_layer(oPlayer.x, oPlayer.y - 64, "UI", oMessageBox);
        msg_box.message = message_text;
        msg_box.display_time = 60;
    }
    
    // Clamp the position of the message box within the room boundaries
    var box_width = max(105, string_width(message_text) + 16); 
    var box_height = max(32, string_height(message_text) + 16); 

    msg_box.x = clamp(oPlayer.x, box_width / 2, room_width - box_width / 2);
    msg_box.y = clamp(oPlayer.y - 64, box_height / 2, room_height - box_height / 2);
    
    message_text = ""; // Reset message_text after displaying
}


// Display weapon message if weapon_text is not empty
if (weapon_text != "") {
    var existing_wep_box = instance_exists(oWeaponBox);
    var wep_box;

    // Get the camera/view position
    var view_x = camera_get_view_x(view_camera[0]);  // Get the x position of the camera view
    var view_y = camera_get_view_y(view_camera[0]);  // Get the y position of the camera view

    if (existing_wep_box) {
        wep_box = instance_find(oWeaponBox, 0);
        wep_box.message = weapon_text;
        wep_box.timer = 60;

        // Adjust the box width based on the new message
        wep_box.width = string_width(weapon_text) + 20; // Add padding
        wep_box.x = view_x + (420 / 2) - (wep_box.width / 2); // Re-center
    } else {
        // Retrieve the actual viewport height
        var viewport_height = camera_get_view_height(view_camera[0]); // Use the camera to get the viewport height

        // Calculate the width of the weapon box based on the text
        var text_width = string_width(weapon_text);
        var box_width = text_width + 20; // Add padding around the text

        // Set specific position for the weapon box
        var x_pos_wep = view_x + (420 / 2) - (box_width / 2); // Centered horizontally
        var y_pos_wep = view_y + viewport_height - 210; // Positioned near the bottom

        wep_box = instance_create_layer(x_pos_wep - 30, y_pos_wep, "UI", oWeaponBox);
        wep_box.message = weapon_text;
        wep_box.display_time = 60;
        wep_box.width = box_width; // Set the box width based on text
    }
    weapon_text = ""; // Reset weapon_text after displaying
}


    // Handle Escape key press
    if (keyboard_check_pressed(vk_escape)) {
        if (global.show_controls || global.show_inventory || global.show_equip) {
            // Close the sub-menu and return to party stats
            global.show_controls = false;
            global.show_inventory = false;
			global.show_equip = false;
        } else {
            // Ensure the game is paused
            global.game_paused = true;
        }
    }
}

// Handle confirmation dialogs
if (global.menu_state == "confirm_quit") {
    // Clear the "just entered" flag
    if (just_entered_confirmation) {
        just_entered_confirmation = false;
    } 
    else {
        // Left/Right: Toggle Yes/No
        if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
            global.selected_confirmation = 1; // Yes
            audio_play_sound(snd_Menu, 1, false);
        }
        if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
            global.selected_confirmation = 0; // No
            audio_play_sound(snd_Menu, 1, false);
        }
        
        // Enter: Confirm selection
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);
            if (global.selected_confirmation == 1) {
                game_end();
            } else {
                global.menu_state = "main";
				
            }
		}
        
        // ESC: Only cancel confirmation (don't close pause menu)
        if (keyboard_check_pressed(vk_escape)) {
            audio_play_sound(snd_Menu, 1, false);
            global.menu_state = "main"; // Just return to pause menu            
        }
    }
}