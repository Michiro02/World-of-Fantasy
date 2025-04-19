draw_self();
draw_set_font(fnDialogue);
// Draw the ChatUI sprite if the player is near the NPC
if (chat_ui_visible) {
    draw_sprite(ChatUI, 0, x + 2, y - 26); // Draw the sprite slightly above the NPC
}

if (dialogue_visible) {
    var dialogue_x = clamp(oPlayer.x - 140, 10, room_width - 300 - 10);
    var dialogue_y = clamp(oPlayer.y - 95, 5, room_height - 50 - 10);
    var dialogue_width = 300;
    var dialogue_height;
    var border_padding = 4;

    if (dialogue_state == 0) {
        // Initial dialogue display logic (unchanged)
        dialogue_height = 70;
        draw_set_color(c_black);
        draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                       dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);
        draw_set_color(c_blue);
        draw_rectangle(dialogue_x, dialogue_y,
                       dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);
        draw_set_color(c_white);
        draw_text(dialogue_x + 10, dialogue_y + 10, npc_name + ": " + dialogue_sequence[0].text);
    } else if (dialogue_state == 1) {
        // Shop menu display logic with scrollable list
        var max_visible_items = 5; // Number of items visible at once
        dialogue_height = 50 + (max_visible_items + 1) * 20; // Adjust height based on visible items
        draw_set_color(c_black);
        draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                       dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);
        draw_set_color(c_blue);
        draw_rectangle(dialogue_x, dialogue_y,
                       dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);
        draw_set_color(c_white);

        draw_set_font(fnDialogue);
        draw_text(dialogue_x + 15, dialogue_y + 10, "Name");
        draw_text(dialogue_x + 150, dialogue_y + 10, "Cost");
        draw_text(dialogue_x + 250, dialogue_y + 10, "Owned");
        draw_text(dialogue_x + 0, dialogue_y + 15, "___________________________________________");

        // Loop through visible weapons and display details
        for (var i = scroll_offset; i < min(scroll_offset + max_visible_items, array_length(weapons_for_sale)); i++) {
            var weapon_entry = weapons_for_sale[i];
            var weapon_y = dialogue_y + 30 + ((i - scroll_offset) * 15); // Adjust Y position based on scroll offset

            draw_text(dialogue_x + 15, weapon_y, weapon_entry.weapon.name);
            draw_text(dialogue_x + 150, weapon_y, string(weapon_entry.price) + " Money");

            var stock_count = get_weapon_stock(weapon_entry.weapon);
            draw_text(dialogue_x + 250, weapon_y, string(stock_count));

            if (i == selected_weapon_index) {
                draw_sprite(sPointer, 0, dialogue_x + 20, weapon_y + 5);
            }
        }

        // Draw the scroll bar
        if (array_length(weapons_for_sale) > max_visible_items) {
            var scroll_bar_x = dialogue_x + dialogue_width - 10; // Position the scroll bar on the right side
            var scroll_bar_y = dialogue_y + 30;
            var scroll_bar_height = max_visible_items * 15;

            // Draw the scroll bar background
            draw_set_color(c_black);
            draw_rectangle(scroll_bar_x, scroll_bar_y, scroll_bar_x + 5, scroll_bar_y + scroll_bar_height, false);

            // Calculate the scroll bar thumb position
            var scroll_thumb_height = scroll_bar_height * (max_visible_items / array_length(weapons_for_sale));
            var scroll_thumb_y = scroll_bar_y + (scroll_offset / array_length(weapons_for_sale)) * scroll_bar_height;

            // Draw the scroll bar thumb
            draw_set_color(c_white);
            draw_rectangle(scroll_bar_x, scroll_thumb_y, scroll_bar_x + 5, scroll_thumb_y + scroll_thumb_height, false);
        }

        draw_text(dialogue_x + 0, dialogue_y + 100, "___________________________________________");

        var close_y = dialogue_y + 30 + (max_visible_items * 20);
        draw_text(dialogue_x + 20, close_y - 20, "Exit");

        draw_text(dialogue_x + 200, dialogue_y + 110, "Money: " + string(global.totalMoney));
        draw_text(dialogue_x + 0, dialogue_y + 115, "___________________________________________");

        // Automatically select "Exit" when scrolling past the last item
        if (selected_weapon_index >= array_length(weapons_for_sale)) {
            draw_sprite(sPointer, 0, dialogue_x + 20, close_y - 15);
        }

        // *** Display the description of the selected weapon ***
        if (selected_weapon_index < array_length(weapons_for_sale)) {
            var selected_weapon_entry = weapons_for_sale[selected_weapon_index];

            var description_x = dialogue_x;
            var description_y = close_y + 30; // Position it below the "Exit" option

            draw_set_font(fnDialogue);
            draw_text(description_x + 0, description_y - 33, "Info:");
            draw_text(description_x + 0, description_y - 20, selected_weapon_entry.weapon.description);
        }
        // *** End of new section ***
    } else if (dialogue_state == 2) {
        // Quantity selection logic (unchanged)
        dialogue_height = 100;
        draw_set_color(c_black);
        draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                       dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);
        draw_set_color(c_blue);
        draw_rectangle(dialogue_x, dialogue_y,
                       dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);
        draw_set_color(c_white);

        var weapon_entry = weapons_for_sale[selected_weapon_index];
        var total_price = weapon_entry.price * selected_quantity;

        draw_text(dialogue_x + 10, dialogue_y + 10, npc_name + ": How many would you like?");
        draw_text(dialogue_x + 0, dialogue_y + 15, "___________________________________________");
        draw_text(dialogue_x + 15, dialogue_y + 40, "Name");
        draw_text(dialogue_x + 100, dialogue_y + 40, "Quantity");
        draw_text(dialogue_x + 180, dialogue_y + 40, "Cost");
        draw_text(dialogue_x + 250, dialogue_y + 40, "Total");

        draw_text(dialogue_x + 15, dialogue_y + 60, weapon_entry.weapon.name);
        draw_text(dialogue_x + 180, dialogue_y + 60, string(weapon_entry.price));
        draw_text(dialogue_x + 250, dialogue_y + 60, string(total_price));

        draw_text(dialogue_x + 105, dialogue_y + 60, "< " + string(selected_quantity) + " >");

        draw_text(dialogue_x + 0, dialogue_y + 70, "___________________________________________");
        draw_text(dialogue_x + 15, dialogue_y + 80, "Cancel");
        draw_text(dialogue_x + 175, dialogue_y + 80, "Money: " + string(global.totalMoney));

        if (cancel_selection) {
            draw_sprite(sPointer, 0, dialogue_x + 20, dialogue_y + 82);
        } else {
            draw_sprite(sPointer, 0, dialogue_x + 20, dialogue_y + 62);
        }
    } else if (dialogue_state == 3) {
        // Thank you dialogue (unchanged)
        dialogue_height = 50;
        draw_set_color(c_black);
        draw_rectangle(dialogue_x - border_padding, dialogue_y - border_padding,
                       dialogue_x + dialogue_width + border_padding, dialogue_y + dialogue_height + border_padding, false);
        draw_set_color(c_blue);
        draw_rectangle(dialogue_x, dialogue_y,
                       dialogue_x + dialogue_width, dialogue_y + dialogue_height, false);
        draw_set_color(c_white);
        draw_text(dialogue_x + 10, dialogue_y + 10, npc_name + ": Thank you for your visit!");
    }
}

// Draw the custom UI if necessary
if (global.ui_state == 1) {
    var ui_message = global.ui_message;
    var ui_box_width = 300;  // Set the desired width
    var ui_box_height = 50;  // Set the desired height
    var ui_x = view_xview[0] + (view_wview[0] / 2) - (ui_box_width / 2);
    var ui_y = view_yview[0] + (view_hview[0] / 2) - (ui_box_height / 2);

    // Draw the stretched UI box
    draw_sprite_stretched(sBox, 0, ui_x + 30, ui_y, ui_box_width, ui_box_height);

    // Draw the message text
    draw_text(ui_x + 40, ui_y + 10, ui_message);
}