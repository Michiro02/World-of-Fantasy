var distance_to_player = point_distance(x, y, oPlayer.x, oPlayer.y);

// Check if the player is within range to interact with the NPC
if (distance_to_player < dialogue_range) {
    // Show the ChatUI sprite when the player is near the NPC
    chat_ui_visible = true;
	
if (distance_to_player < dialogue_range) {
    if (keyboard_check_pressed(vk_enter)) {
        if (!global.game_paused) {
            audio_play_sound(snd_Menu, 1, false);

            if (!dialogue_visible) {
                dialogue_visible = true;
                global.dialogue_active = true;
                dialogue_state = 0;
            } else {
                if (dialogue_state == 0) {
                    dialogue_state = 1;
                } else if (dialogue_state == 1) {
                    if (selected_weapon_index == array_length(weapons_for_sale)) {
                        dialogue_state = 3; // Move to farewell state
                    } else {
                        dialogue_state = 2;
                        selected_quantity = 1;
                        cancel_selection = false;
                    }
                } else if (dialogue_state == 2) {
                    if (cancel_selection) {
                        dialogue_state = 1;
                    } else {
                        var selected_weapon_entry = weapons_for_sale[selected_weapon_index];
                        var total_price = selected_weapon_entry.price * selected_quantity;

                        if (global.totalMoney >= total_price) {
                            global.totalMoney -= total_price;

                            var found = false;
                            for (var i = 0; i < array_length(global.weaponInventory); i++) {
                                if (global.weaponInventory[i][0] == selected_weapon_entry.weapon) {
                                    global.weaponInventory[i][1] += selected_quantity;
                                    found = true;
                                    break;
                                }
                            }
                            if (!found) {
                                array_push(global.weaponInventory, [selected_weapon_entry.weapon, selected_quantity]);
                            }

                            var weapon_name = string(selected_weapon_entry.weapon.name);
                            var weapon_message = "You bought " + string(selected_quantity) + " " + weapon_name;
                            
                            show_ui_message(weapon_message + "!", 1);
                        } else {
                            show_ui_message("You don't have enough money to buy this\nquantity.", 1);
                        }
                    }
                    dialogue_state = 1;
                } else if (dialogue_state == 3) {
                    dialogue_visible = false;
                    global.dialogue_active = false;
                    selected_weapon_index = 0;
                }
            }
        }
    }
	
	
	// Only handle ESC key if the dialogue is visible
    if (dialogue_visible && keyboard_check_pressed(vk_escape)) {
        audio_play_sound(snd_Menu, 1, false);
        if (dialogue_state == 2) {
            // Go back to item selection
            dialogue_state = 1;
        } else if (dialogue_state == 1) {
            // Exit dialogue completely
            dialogue_state = 3;
        } else if (dialogue_state == 0 || dialogue_state == 3) {
            // Fully exit
            dialogue_visible = false;
            global.dialogue_active = false;
        }
    }

 if (dialogue_visible && dialogue_state == 1) {
    if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
        audio_play_sound(snd_Menu, 1, false);

        if (selected_weapon_index > 0) {
            selected_weapon_index--;
        } else {
            // If at the first item, move to Exit
            selected_weapon_index = array_length(weapons_for_sale);
            scroll_offset = max(0, array_length(weapons_for_sale) - max_visible_items); // Move scroll to show exit
        }

        // Adjust scrolling if needed
        if (selected_weapon_index < scroll_offset) {
            scroll_offset = max(0, scroll_offset - 1);
        }
    }

    if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
        audio_play_sound(snd_Menu, 1, false);

        if (selected_weapon_index < array_length(weapons_for_sale)) {
            selected_weapon_index++;
        } else {
            // If at Exit, wrap back to the first item
            selected_weapon_index = 0;
            scroll_offset = 0; // Reset scrolling
        }

        // Adjust scrolling if needed
        if (selected_weapon_index >= scroll_offset + max_visible_items) {
            scroll_offset = min(array_length(weapons_for_sale) - max_visible_items, scroll_offset + 1);
        }
    }
}
    if (dialogue_visible && dialogue_state == 2) {
        if (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)) {
            selected_quantity = max(1, selected_quantity - 1);
            audio_play_sound(snd_Menu, 1, false);
        }
        if (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)) {
            selected_quantity = min(99, selected_quantity + 1);
            audio_play_sound(snd_Menu, 1, false);
        }

        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(ord("S")) || 
			keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_down)) {
            cancel_selection = !cancel_selection;
            audio_play_sound(snd_Menu, 1, false);
        }
    }
}

// Decrease the timer for the UI message
if (global.ui_timer > 0) {
    global.ui_timer--;
    if (global.ui_timer == 0) {
        global.ui_state = 0; // Hide the UI message when the timer reaches 0
    }
}

} else {
    // Hide the ChatUI sprite when the player is far away
    chat_ui_visible = false;
}
