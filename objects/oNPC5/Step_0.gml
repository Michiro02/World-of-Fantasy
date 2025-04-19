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
                    if (selected_item_index == array_length(items_for_sale)) {
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
                        var selected_item_entry = items_for_sale[selected_item_index];
                        var total_price = selected_item_entry.price * selected_quantity;

                        if (global.totalMoney >= total_price) {
                            global.totalMoney -= total_price;

                            var found = false;
                            for (var i = 0; i < array_length(global.inventory); i++) {
                                if (global.inventory[i][0] == selected_item_entry.item) {
                                    global.inventory[i][1] += selected_quantity;
                                    found = true;
                                    break;
                                }
                            }
                            if (!found) {
                                array_push(global.inventory, [selected_item_entry.item, selected_quantity]);
                            }

                            var item_name = string(selected_item_entry.item.name);
                            var item_message = "You bought " + string(selected_quantity) + " " + item_name;
                          
                            show_ui_message(item_message + "!", 1);
                        } else {
                            show_ui_message("You don't have enough money to buy this\nquantity.", 1);
                        }
                    }
                    dialogue_state = 1;
                } else if (dialogue_state == 3) {
                    dialogue_visible = false;
                    global.dialogue_active = false;
                    selected_item_index = 0;
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

 // Item selection navigation
    if (dialogue_visible && dialogue_state == 1) {
        if (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)) {
            audio_play_sound(snd_Menu, 1, false);

            if (selected_item_index > 0) {
                selected_item_index--;
            } else {
                selected_item_index = array_length(items_for_sale); // Move to "Exit"
                scroll_offset = max(0, array_length(items_for_sale) - max_visible_items);
            }

            if (selected_item_index < scroll_offset) {
                scroll_offset = max(0, scroll_offset - 1);
            }
        }

        if (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) {
            audio_play_sound(snd_Menu, 1, false);

            if (selected_item_index < array_length(items_for_sale)) {
                selected_item_index++;
            } else {
                selected_item_index = 0; // Loop back to first item
                scroll_offset = 0;
            }

            if (selected_item_index >= scroll_offset + max_visible_items) {
                scroll_offset = min(array_length(items_for_sale) - max_visible_items, scroll_offset + 1);
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
