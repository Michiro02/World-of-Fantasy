// Draw Event
// Draw the background with its fade alpha
draw_set_alpha(bg_fade_alpha);
draw_sprite(menu_background_sprite, 0, 0, 0); // Adjust position as needed
draw_set_alpha(1); // Reset alpha

if (is_intro) {
    // Intro drawing logic
    draw_set_alpha(fade_alpha);

    // Display the image if `current_image_index` is set
    if (current_image_index >= 0 && current_image_index < array_length(intro_images)) {
        var img = intro_images[current_image_index];
        draw_sprite(img, 0, room_width / 2 - sprite_get_width(img) / 2, room_height / 2 - sprite_get_height(img) / 2);
    }

    // Draw any text for the intro
    if (intro_step == 0 || intro_step == 1) {
		draw_set_font(fnDialogue_2);
        draw_text(room_width / 2 - 300, room_height / 2 - 50, "This game is for first timers\nand everyone who loves turn-based games...");
    }

    draw_set_alpha(1); // Reset alpha
} else {
	
if (!settings_active) {
    if (global.menu_state == "main") {
		draw_set_alpha(menu_fade_alpha);
        // Existing code to draw the main menu
        var x_pos = 200;
        var y_start = 270;
        var y_offset = 40;

        draw_set_font(fnDialogue_2);
        draw_sprite_stretched(sBox, 0, x_pos - 10, y_start - 20, 256, 4 * y_offset + 40);

        // Draw pointer
        var pointer_x = x_pos - 40;
        var pointer_y = y_start + selected_option * y_offset - 10;
        draw_sprite_stretched(sPointer, 0, pointer_x + 40, pointer_y - 20, 64, 64);

        // Draw "Start Game"
        draw_set_color(selected_option == 0 ? c_yellow : c_white);
        draw_text(x_pos + 50, y_start, "Start Game");

        // Draw "Controls"
        draw_set_color(selected_option == 1 ? c_yellow : c_white);
        draw_text(x_pos + 50, y_start + y_offset, "Settings");

        // Draw "Load Game"
        draw_set_color(selected_option == 2 ? c_yellow : c_white);
        draw_text(x_pos + 50, y_start + 2 * y_offset, "Load Game");

        // Draw "Quit Game"
        draw_set_color(selected_option == 3 ? c_yellow : c_white);
        draw_text(x_pos + 50, y_start + 3 * y_offset, "Quit Game");
		
		draw_set_alpha(1); // Reset alpha

    } else if (global.menu_state == "load_select") {
        // Drawing the Load Game slots
        var save_slot_x = 180;
        var save_slot_y = 110;
        var vertical_spacing = 133;

        for (var i = 1; i <= 3; i++) {
            var filename = "savegame" + string(i) + ".txt";
            draw_set_color(global.selected_slot == i ? c_yellow : c_white);

            var text = "";

            if (file_exists(filename)) {
                var file = file_text_open_read(filename);
                
                // Read the save details
                var save_datetime = file_text_read_string(file);
                file_text_readln(file);

                // Skip unnecessary data
                file_text_read_real(file); file_text_readln(file);
                file_text_read_real(file); file_text_readln(file);
                file_text_read_real(file); file_text_readln(file);

                // Read room and player stats
                var room_name = file_text_read_string(file);
                file_text_readln(file);
                var display_room_name = string_replace_all(room_name, "_", " ");
                var total_money = file_text_read_real(file);
                file_text_readln(file);
                var player_level = file_text_read_real(file);
                file_text_readln(file);

                file_text_close(file);

                text = "Slot " + string(i) + ": " + save_datetime + "\n\nLocation: " + display_room_name + "\n\nLvl: " + string(player_level) + "\n\nMoney: " + string(total_money);
            } else {
                text = "Slot " + string(i) + ": No save file";
            }

            // Draw the save slot box
            draw_sprite_stretched(Save, 0, save_slot_x - 50, save_slot_y + ((i - 1) * vertical_spacing) - 10, 400, 130);

            // Draw the save slot text
            draw_text(save_slot_x - 40, save_slot_y + ((i - 1) * vertical_spacing), text);

            // Draw pointer for the selected slot
            if (global.selected_slot == i) {
                draw_sprite_stretched(sPointer, 0, save_slot_x - 90, save_slot_y + ((i - 1) * vertical_spacing), 50, 50);
            }
        }
    } else if (global.menu_state == "settings") {
    // Drawing the Settings menu
    var settings_x = 30;
    var settings_y = 210;
    var settings_width = 600;
    var settings_height = 290;

    draw_set_font(fnDialogue_2);
    draw_sprite_stretched(sBox, 0, settings_x, settings_y, settings_width, settings_height);

    // Draw pointer sprite next to the selected option
    var pointer_x = settings_x - 40;
    var pointer_y = settings_y + selected_option * 40;
    draw_sprite_stretched(sPointer, 0, pointer_x + 15, pointer_y, 64, 64);

    // Draw "Controls"
    draw_set_color(selected_option == 0 ? c_yellow : c_white); // Highlight if selected
    draw_text(settings_x + 20, settings_y + 30, "Controls");

    // Draw "Volume" option with current percentage display
    draw_set_color(selected_option == 1 ? c_yellow : c_white); // Highlight if selected
    var volume_percentage = round(global.volume * 100);
    draw_text(settings_x + 20, settings_y + 70, "Volume: " + string(volume_percentage) + "% (Use A/D or Left/Right)");

} else if (global.menu_state == "controls") {
    // Drawing Controls menu
    var controls_x = 30;
    var controls_y = 210;
    var controls_width = 600;
    var controls_height = 390;

    draw_set_font(fnDialogue_2);
    draw_sprite_stretched(sBox, 0, controls_x, controls_y, controls_width, controls_height);

    draw_set_color(c_white);
    draw_text(controls_x + 20, controls_y + 10, "Controls Menu");
    draw_text(controls_x + 20, controls_y + 45, "Move Up: W / Up Arrow");
    draw_text(controls_x + 20, controls_y + 75, "Move Down: S / Down Arrow");
    draw_text(controls_x + 20, controls_y + 105, "Move Right: D / Right Arrow");
    draw_text(controls_x + 20, controls_y + 135, "Move Left: A / Left Arrow");
    draw_text(controls_x + 20, controls_y + 165, "Confirm/Talk: Enter");
    draw_text(controls_x + 20, controls_y + 195, "Back/Cancel/Pause: Esc");
    draw_text(controls_x + 20, controls_y + 225, "Target All: Shift");
	draw_text(controls_x + 20, controls_y + 255, "Fullscreen: F");
		}
	}
}