// Draw the fade-out effect
draw_set_alpha(alpha);
draw_set_color(c_black);
draw_rectangle(0, 0, display_get_width(), display_get_height(), false);
draw_set_alpha(1);
draw_set_font(fnDialogue_2);

    // Reset alignment to default values after drawing text
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

// Draw the confirmation dialog
if (global.menu_state == "confirm_save") {
    // Define the confirmation box size and position
    var box_width = 350;
    var box_height = 100;
    var box_x = 150; // Center horizontally
    var box_y = 150; // Center vertically

    // Draw the confirmation box (stretched Save sprite or a rectangle)
    draw_sprite_stretched(Save, 0, box_x - 30, box_y, box_width, box_height);

    // Draw the confirmation text
    draw_set_color(c_white);
    draw_text(box_x - 20, box_y + 20, "Do you want to save your");
	draw_text(box_x + 80, box_y + 40, "progress?");
    // Draw the "Yes" and "No" options
    draw_set_color(global.selected_confirmation == 1 ? c_yellow : c_white);
    draw_text(box_x + 40, box_y + 80, "Yes");

    draw_set_color(global.selected_confirmation == 0 ? c_yellow : c_white);
    draw_text(box_x + 160, box_y + 80, "No");

    // Draw the pointer sprite next to the selected option
    var pointer_x = global.selected_confirmation == 1 ? box_x + 20 : box_x + 140;
    draw_sprite_stretched(sPointer, 0, pointer_x - 20, box_y + 55, 50, 50);
}

// Draw the save slot selection
if (global.menu_state == "save_select") {
    // Define the vertical spacing between each slot
    var vertical_spacing = 130;

    // Define the position of the save slots
    var save_slot_x = 150; // Center horizontally
    var save_slot_y = 70; // Center vertically

    // Draw each save slot
    for (var i = 1; i <= 3; i++) {
        var filename = "savegame" + string(i) + ".txt";
        draw_set_color(global.selected_slot == i ? c_yellow : c_white);

        var text = "";

        if (file_exists(filename)) {
            var file = file_text_open_read(filename);
            
            // Read the date and time
            var save_datetime = file_text_read_string(file);
            file_text_readln(file);

            // Skip player position and room index
            var player_x = file_text_read_real(file);
            file_text_readln(file);
            var player_y = file_text_read_real(file);
            file_text_readln(file);
            var room_index = file_text_read_real(file);
            file_text_readln(file);

            // Read the room name (location)
            var room_name = file_text_read_string(file);
            file_text_readln(file);

            // Replace underscores with spaces for display
            var display_room_name = string_replace_all(room_name, "_", " ");

            // Read the correct values
            var total_money = file_text_read_real(file);
            file_text_readln(file);
            var player_level = file_text_read_real(file);
            file_text_readln(file);

            file_text_close(file);

            // Set the text after loading the file
            text = "Slot " + string(i) + ": " + save_datetime + "\n\nLocation: " + display_room_name + "\n\nLvl: " + string(player_level) + "\n\nMoney: " + string(total_money);
        } else {
            text = "Slot " + string(i) + ": No save file";
        }

        // Draw the save slot box
            draw_sprite_stretched(Save, 0, save_slot_x - 50, save_slot_y + ((i - 1) * vertical_spacing) - 10, 400, 130);

            // Draw the save slot text
            draw_text(save_slot_x - 40, save_slot_y + ((i - 1) * vertical_spacing), text);

        // Draw the pointer next to the selected slot
        if (global.selected_slot == i) {
            draw_sprite_stretched(sPointer, 0, save_slot_x - 100, save_slot_y + ((i - 1) * vertical_spacing + 10), 50,50);
        }
    }
}