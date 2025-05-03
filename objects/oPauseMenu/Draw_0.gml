// draw event

// Draw a blue rectangle to cover the entire screen
draw_set_color(make_color_rgb(65, 105, 225));
draw_rectangle(0, 0, display_get_width(), display_get_height(), false);

// Set custom font (assuming fnDialogue_1 is your custom font resource)
draw_set_font(fnDialogue_1);

// Get the camera/view position (assuming using view[0])
var view_x = camera_get_view_x(view_camera[0]);  // Get the x position of the camera view
var view_y = camera_get_view_y(view_camera[0]);  // Get the y position of the camera view

// Define the viewport size
var viewport_width = 320;  // Set viewport width
var viewport_height = 200;  // Set viewport height

// Define the menu's position relative to the center of the view
var menu_x = view_x + (viewport_width - 300) / 2;  // Center menu horizontally within the view
var menu_y = view_y + (viewport_height - 180) / 2;  // Center menu vertically within the view

// Reset alpha to 1 for drawing other elements
draw_set_alpha(1);

// Define the menu options positions relative to the centered menu position
var option_positions = [
    [menu_x, menu_y - 8], // Game Paused
    [menu_x + 325, menu_y + 12], // Save Game
    [menu_x + 325, menu_y + 22], // Load Game
    [menu_x + 325, menu_y + 32], // Items
    [menu_x + 325, menu_y + 42], // Controls
    [menu_x + 325, menu_y + 52], // Equip
    [menu_x + 325, menu_y + 82], // Quit
    [menu_x + 325, menu_y + 102], // Volume
    [menu_x + 322, menu_y + 122], // Money
    [menu_x + 320, menu_y + 110], // ____
    [menu_x + 320, menu_y + 140], // Message Text (new addition)
];

draw_sprite(Option, 0, menu_x + 319, menu_y + 0); // Draw `Option` sprite once

// Draw the menu options
draw_set_color(global.selected_item == 0 ? c_yellow : c_white);
draw_text(option_positions[0][0], option_positions[0][1], "GAME PAUSED: (Use W,S Keys to navigate)");

draw_set_color(global.selected_item == 1 ? c_yellow : c_white);
draw_text(option_positions[1][0], option_positions[1][1], "Save Game");

draw_set_color(global.selected_item == 2 ? c_yellow : c_white);
draw_text(option_positions[2][0], option_positions[2][1], "Load Game");

draw_set_color(global.selected_item == 3 ? c_yellow : c_white);
draw_text(option_positions[3][0], option_positions[3][1], "Items");

draw_set_color(global.selected_item == 4 ? c_yellow : c_white);
draw_text(option_positions[4][0], option_positions[4][1], "Controls");

draw_set_color(global.selected_item == 5 ? c_yellow : c_white);
draw_text(option_positions[5][0], option_positions[5][1], "Equip");

draw_set_color(global.selected_item == 6 ? c_yellow : c_white);
draw_text(option_positions[6][0], option_positions[6][1], "Quit");

draw_set_color(global.selected_item == 7 ? c_yellow : c_white);
var volume_percentage = round(global.volume * 100);
draw_text(option_positions[7][0], option_positions[7][1], "Volume:"+ string(volume_percentage) + "%");

draw_set_color(global.selected_item == 8 ? c_yellow : c_white);
draw_text(option_positions[8][0], option_positions[8][1], "Money:" + string(global.totalMoney));

draw_set_color(global.selected_item == 9 ? c_yellow : c_white);
draw_text(option_positions[9][0], option_positions[9][1], "______________________");

draw_set_color(global.selected_item == 10 ? c_yellow : c_white);
draw_text(option_positions[10][0], option_positions[10][1], message_text); // Fixed: message_text will be displayed correctly


if (global.menu_state == "equip_weapon") {
    // Draw the background first
    draw_sprite_stretched(Menu, 0, menu_x - 10, menu_y, 330, 230);

    // Draw the title text
    draw_set_color(c_white); // Reset the color to white for title text
    draw_text(menu_x + 5, menu_y + 10, "Select a weapon to equip:");

    // Draw weapon inventory
    var item_height = 15;
    var weapon_count = array_length(global.weaponInventory);

    // If there are no weapons in inventory, display a message
    if (weapon_count > 0) {
        // Clamp the selected weapon index within the range
        global.selected_weapon_index = clamp(global.selected_weapon_index, 0, weapon_count - 1);
    } else {
        // If no weapons, disable selection and show message
        global.selected_weapon_index = -1;
        draw_set_color(c_white);
        draw_text(menu_x + 20, menu_y + 60, "No weapons available.");
    }

    // Calculate the visible range for scrolling
    var visible_items = 10; // Number of items visible at once
    var start_index = max(0, global.selected_weapon_index - visible_items + 1);
    var end_index = min(weapon_count, start_index + visible_items);

    // If there are weapons, draw them in the menu
    for (var i = start_index; i < end_index; i++) {
        var weapon = global.weaponInventory[i][0]; // Now correctly refers to the weapon object
        draw_set_color(global.selected_weapon_index == i ? c_yellow : c_white);
        draw_text(menu_x + 20, menu_y + 25 + (i - start_index) * item_height, weapon.name + " x" + string(global.weaponInventory[i][1]));
    }

    // Draw the sPointer if there is a valid selection
    if (global.selected_weapon_index != -1) {
        draw_sprite(sPointer, 0, menu_x + 20, menu_y + 27 + (global.selected_weapon_index - start_index) * item_height);
    }

    // Draw the navigation bar
    if (weapon_count > visible_items) {
        var bar_x = menu_x + 300; // Position of the scroll bar
        var bar_y = menu_y + 25;
        var bar_height = visible_items * item_height;
        var thumb_height = (visible_items / weapon_count) * bar_height;
        var thumb_position = (start_index / weapon_count) * bar_height;

        // Draw the scroll bar background
        draw_set_color(c_black);
        draw_rectangle(bar_x, bar_y, bar_x + 5, bar_y + bar_height, false);

        // Draw the scroll bar thumb
        draw_set_color(c_white);
        draw_rectangle(bar_x, bar_y + thumb_position, bar_x + 5, bar_y + thumb_position + thumb_height, false);
    }

    // Draw the selected weapon description if there is a valid selection
    if (weapon_count > 0 && global.selected_weapon_index != -1) {
        var selected_weapon = global.weaponInventory[global.selected_weapon_index][0]; // Now correctly refers to the weapon object
        draw_set_color(c_white);
        draw_text(menu_x - 5, menu_y + 190, "______________________________________________");
        draw_text(menu_x + 10, menu_y + 200, selected_weapon.description);
    }
}

if (global.menu_state == "equip_member") {
    // Draw the background first
    draw_sprite_stretched(Menu, 0, menu_x - 10, menu_y, 330, 230);

    // Draw the title text
    draw_set_color(c_white); // Reset the color to white for title text
    draw_text(menu_x + 5, menu_y + 10, "Select a party member to equip");

    // Ensure a weapon is selected
    if (global.selected_weapon_index != -1) {
        var selected_weapon = global.weaponInventory[global.selected_weapon_index][0];
        draw_text(menu_x + 5, menu_y + 30, "Weapon: " + selected_weapon.name);  // This will show the selected weapon
    }

    // Draw party members and their currently equipped weapon
    var spacing_y = 25;
    for (var i = 0; i < array_length(global.party); i++) {
        var member = global.party[i];
        draw_set_color(global.selected_party_member_index == i ? c_yellow : c_white);
        draw_text(menu_x + 20, menu_y + 60 + i * spacing_y, member.name);

        // Show equipped weapon (if any)
        if (member.equippedWeapon != undefined) {
            draw_text(menu_x + 130, menu_y + 60 + i * spacing_y, "Equipped: " + member.equippedWeapon.name);
        } else {
            draw_text(menu_x + 150, menu_y + 60 + i * spacing_y, "No Weapon");
        }
    }

    // Draw the sPointer
    draw_sprite(sPointer, 0, menu_x + 20, menu_y + 60 + global.selected_party_member_index * spacing_y);
}


if (global.show_controls) {
    // Define where to draw the controls menu
    var settings_x = menu_x - 10;
    var settings_y = menu_y + 0;

    // Draw the `Menu` sprite as the background for the controls
    draw_sprite_stretched(Menu, 0, settings_x, settings_y, 330, 230);

    // Draw settings text on top of the Menu sprite
    draw_set_color(c_white);
    draw_text(settings_x + 10, settings_y + 10, "Controls:");
    draw_text(settings_x + 10, settings_y + 30, "Move Up: W / Up Arrow");
    draw_text(settings_x + 10, settings_y + 45, "Move Down: S / Down Arrow");
    draw_text(settings_x + 10, settings_y + 65, "Move Right: D / Right Arrow");
    draw_text(settings_x + 10, settings_y + 85, "Move Left: A / Left Arrow");
    draw_text(settings_x + 10, settings_y + 105, "Confirm/Talk: Enter");
    draw_text(settings_x + 10, settings_y + 125, "Back/Cancel/Pause: Esc");
    draw_text(settings_x + 10, settings_y + 145, "Target All: Shift");
	draw_text(settings_x + 10, settings_y + 165, "Volume Down: A/ Left Arrow");
	draw_text(settings_x + 10, settings_y + 185, "Volume Up: D/ Right Arrow");
	draw_text(settings_x + 10, settings_y + 205, "Fullscreen: F");
} else if (global.show_inventory) {
    // Initialize selected_item_index if it hasn't been set yet
    if (!variable_global_exists("selected_item_index")) {
        global.selected_item_index = 0;
    }

    // Define where to draw the inventory menu
    var inv_x = menu_x - 10;
    var inv_y = menu_y + 0;

    // Draw the `Menu` sprite as the background for the inventory
    draw_sprite_stretched(Menu_1, 0, inv_x, inv_y, 330, 230);

    // Draw inventory items on top of the Menu sprite
    var item_height = 20;
    var visible_items = 8; // Number of items visible at once
    var total_items = array_length(global.inventory);

    // Calculate the start and end indices for the visible items
    var start_index = max(0, global.selected_item_index - visible_items + 1);
    var end_index = min(total_items, start_index + visible_items);

    // Draw the visible items
    for (var i = start_index; i < end_index; i++) {
        var item = global.inventory[i];
        var item_name = item[0].name;
        var item_quantity = item[1];
        var item_description = "";

        // Define descriptions for items (example descriptions, adjust as needed)
        switch (item[0]) {
            case global.actionLibrary.potion:
           //     item_description = "Heals 930";
                break;
            case global.actionLibrary.revive:
            //    item_description = "Revive an ally";
                break;
            case global.actionLibrary.ether:
            //    item_description = "Restores 1500 MP";
                break;
            case global.actionLibrary.elixir:
            //    item_description = "Heals 1500 and Restores 1500 MP";
                break;
            case global.actionLibrary.HighPotion:
            //    item_description = "Fully heals";
                break;
            case global.actionLibrary.HighElixir:
           //     item_description = "Fully Heals and Recover MP";
                break;
            case global.actionLibrary.HighEther:
           //     item_description = "Fully restores MP";
                break;
            case global.actionLibrary.XEther:
           //     item_description = "Fully restores MP to all members";
                break;
            case global.actionLibrary.Remedy:
           //     item_description = "Removes status ailments";
                break;
            case global.actionLibrary.wipeout:
           //     item_description = "Deals 55000 damage";
                break;
        }
		
		
        // Draw item name and description
        draw_set_color(global.selected_item_index == i ? c_yellow : c_white); // Highlight selected item
        draw_text(inv_x + 30, inv_y + 10 + (i - start_index) * item_height, item_name + ": " + string(item_quantity)); 
		//" (" + item_description + ")");
    }
	
	
    // Draw the pointer sprite next to the selected item
    if (total_items > 0 && global.selected_item_index != -1) {
        var pointer_y = inv_y + 10 + (global.selected_item_index - start_index) * item_height;
        draw_sprite(sPointer, 0, inv_x + 30, pointer_y + 5); // Draw pointer at the left of the selected item
    }
	
	//draw_text(inv_x + 5, inv_y +190, "___________________________________________");
	
    // Draw the scroll bar if there are more items than visible
    if (total_items > visible_items) {
        var bar_x = inv_x + 320; // Position of the scroll bar
        var bar_y = inv_y + 10;
        var bar_height = visible_items * item_height;
        var thumb_height = (visible_items / total_items) * bar_height;
        var thumb_position = (start_index / total_items) * bar_height;

        // Draw the scroll bar background
        draw_set_color(c_black);
        draw_rectangle(bar_x, bar_y, bar_x + 5, bar_y + bar_height, false);

        // Draw the scroll bar thumb
        draw_set_color(c_white);
        draw_rectangle(bar_x, bar_y + thumb_position, bar_x + 5, bar_y + thumb_position + thumb_height, false);
    }

    // Draw the selected item description at the bottom
    if (total_items > 0 && global.selected_item_index != -1) {
        var selected_item = global.inventory[global.selected_item_index];
        var selected_description = "";

        // Define descriptions for the selected item
        switch (selected_item[0]) {
            case global.actionLibrary.potion:
                selected_description = "Heals 930";
                break;
            case global.actionLibrary.revive:
                selected_description = "Revive an ally";
                break;
            case global.actionLibrary.ether:
                selected_description = "Restores 1500 MP";
                break;
            case global.actionLibrary.elixir:
                selected_description = "Heals 1500 and Restores 1500 MP";
                break;
            case global.actionLibrary.HighPotion:
                selected_description = "Fully heals";
                break;
            case global.actionLibrary.HighElixir:
                selected_description = "Fully Heals and Recover MP";
                break;
            case global.actionLibrary.HighEther:
                selected_description = "Fully restores MP";
                break;
            case global.actionLibrary.XEther:
                selected_description = "Fully restores MP to all members";
                break;
			case global.actionLibrary.XPotion:
                selected_description = "Fully restores HP to all members";
                break;	
            case global.actionLibrary.Remedy:
                selected_description = "Removes status ailments";
                break;
            case global.actionLibrary.wipeout:
                selected_description = "Deals 55000 damage";
                break;
        }

        // Draw the selected item description
        draw_set_color(c_white);
        draw_text(inv_x + 10, inv_y + 200, "Info: " + selected_description);
    }
} else if (!global.show_controls && !global.show_inventory && !global.show_equip) {
    // Draw the `Party` sprite once before drawing party members
    draw_sprite_stretched(Party, 0, menu_x - 10, menu_y + 0, 330, 290);

    // Draw the stats of all party members in a single column
    var start_x = menu_x + 0;
    var start_y = menu_y + 10;
    var spacing_y = 57; // Spacing for each party member's information

    for (var i = 0; i < array_length(global.party); i++) {
        var party_member = global.party[i];
        var pos_y = start_y + i * spacing_y;

        draw_set_color(c_white);
        // Draw player portrait if available, else skip this part
        draw_sprite(party_member.portrait, 0, start_x + 5, pos_y + 10);

        // Draw player stats next to the portrait
        draw_text(start_x + 50, pos_y, party_member.name);
        draw_text(start_x + 50, pos_y + 10, "Lvl: " + string(party_member.level));
        draw_text(start_x + 50, pos_y + 20, "Exp: " + string(party_member.xp) + "/" + string(party_member.xpNext));
        draw_text(start_x + 50, pos_y + 30, "Role: " + string(party_member.role));
        draw_text(start_x + 50, pos_y + 40, "Strength: " + string(party_member.strength));
        draw_text(start_x + 220, pos_y + 10, "Magic: " + string(party_member.magic));
        draw_text(start_x + 220, pos_y + 20, "HP: " + string(party_member.hp) + "/" + string(party_member.hpMax));
        draw_text(start_x + 220, pos_y + 30, "MP: " + string(party_member.mp) + "/" + string(party_member.mpMax));
    }
}


// Draw the pointer sprite at the selected menu item position
draw_sprite(sPointer, 0, option_positions[global.selected_item][0] + 10, option_positions[global.selected_item][1] + 2);

if (global.menu_state == "confirm_quit") {
    // Draw the confirmation box
    var view_x = camera_get_view_x(view_camera[0]);
    var view_y = camera_get_view_y(view_camera[0]);
    var viewport_width = 420;
    var viewport_height = 250;
    var box_width = 260;
    var box_height = 100;
    var box_x = view_x + (viewport_width - box_width) / 2;
    var box_y = view_y + (viewport_height - box_height) / 2;

    draw_sprite_stretched(Save, 0, box_x - 30, box_y, box_width, box_height);
    
    // Draw the confirmation text
    draw_set_color(c_white);
    draw_text(box_x - 20, box_y + 20, "  Do you want to quit the game?");
    
    // Draw the "Yes" and "No" options
    var yes_text_x = box_x + 40;
    var no_text_x = box_x + 140;
    var text_y = box_y + 60;

    draw_set_color(global.selected_confirmation == 1 ? c_yellow : c_white);
    draw_text(yes_text_x, text_y, "Yes");

    draw_set_color(global.selected_confirmation == 0 ? c_yellow : c_white);
    draw_text(no_text_x, text_y, "No");

    // Draw the pointer
    var pointer_x = global.selected_confirmation == 1 ? yes_text_x - 20 : no_text_x - 20;
    draw_sprite(sPointer, 0, pointer_x + 20, text_y + 5);
}

if (global.menu_state == "confirm_save" || global.menu_state == "confirm_load") {
    // Get the view's position (assuming using view[0])
    var view_x = camera_get_view_x(view_camera[0]);  // Get the x position of the camera view
    var view_y = camera_get_view_y(view_camera[0]);  // Get the y position of the camera view

    // Define the viewport size
    var viewport_width = 420;  // Set viewport width
    var viewport_height = 250;  // Set viewport height

    // Define confirmation box size and position it in the center of the view
    var box_width = 260;
    var box_height = 100;
    var box_x = view_x + (viewport_width - box_width) / 2;  // Center box horizontally within the view
    var box_y = view_y + (viewport_height - box_height) / 2;  // Center box vertically within the view

    // Draw the confirmation box (stretched Save sprite)
    draw_sprite_stretched(Save, 0, box_x - 30, box_y, box_width, box_height);

    // Set up the confirmation text based on the menu state
    var confirmation_text = (global.menu_state == "confirm_save") ? "Do you want to save your progress?" : "Do you want to load your progress?";
    draw_set_color(c_white);
    draw_text(box_x - 20, box_y + 20, confirmation_text);  // Display the confirmation question

    // Define the "Yes" and "No" options positions
    var yes_text_x = box_x + 40;
    var no_text_x = box_x + 140;
    var text_y = box_y + 60;

    // Draw the "Yes" and "No" options
    draw_set_color(global.selected_confirmation == 1 ? c_yellow : c_white);
    draw_text(yes_text_x, text_y, "Yes");

    draw_set_color(global.selected_confirmation == 0 ? c_yellow : c_white);
    draw_text(no_text_x, text_y, "No");

    // Draw the pointer sprite next to the selected option
    var pointer_x = global.selected_confirmation == 1 ? yes_text_x - 20 : no_text_x - 20;
    draw_sprite(sPointer, 0, pointer_x + 20, text_y + 5);
}


// Define the vertical spacing between each slot
var vertical_spacing = 75;  // Increase this value to add more space between slots

// Adjust these variables to change the position of the sBox
var sBox_x_offset = -10;  // Horizontal offset
var sBox_y_offset = -60;  // Vertical offset

// Define the width and height for the UI border (sBox)
var sBox_width = 250;   // Custom width
var sBox_height = 75;  // Custom height

if (global.menu_state == "save_select" || global.menu_state == "load_select") {
    // Use menu_x and menu_y to position the save/load slots
    var save_slot_x = menu_x + 60 + sBox_x_offset;  // Add the horizontal offset
    var save_slot_y = menu_y + 100 + sBox_y_offset;  // Add the vertical offset
	//draw_sprite_stretched(sBox,0,save_slot_x - 40, save_slot_y - 10, sBox_width + 50,sBox_height + 150);

    for (var i = 1; i <= 3; i++) {
        var filename = "savegame" + string(i) + ".txt";
        draw_set_color(global.selected_slot == i ? c_yellow : c_white);

        var text = "";

        if (file_exists(filename)) {
            var file = file_text_open_read(filename);
            
            // Read the date and time first
            var save_datetime = file_text_read_string(file);
            file_text_readln(file);

            // Skip the player position and room index
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
		
        // Draw the sBox sprite as a stretched background at the new position with custom width and height
        draw_sprite_stretched(Save, 0, save_slot_x - 10, save_slot_y + ((i - 1) * vertical_spacing) - 10, sBox_width, sBox_height);

        // Draw the text inside the sBox border
        draw_set_color(global.selected_slot == i ? c_yellow : c_white);
        draw_text(save_slot_x, save_slot_y + ((i - 1) * vertical_spacing), text);

        // Check if this is the currently selected slot and draw the pointer
        if (global.selected_slot == i) {
            // Adjust the pointer's position to be next to the currently selected slot
            draw_sprite(sPointer, 0, save_slot_x - 10, save_slot_y + ((i - 1) * vertical_spacing + 10));
        }
    }
}