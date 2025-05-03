if (!variable_global_exists("show_inventory")) {
    global.show_inventory = false;
}

if (!variable_global_exists("show_controls")) {
    global.show_controls = false;
}

if (!variable_global_exists("selected_item")) {
    global.selected_item = 1; // Start at the first menu option
}

if (!variable_global_exists("menu_state")) {
    global.menu_state = "main"; // Main menu state by default
}

if (!variable_global_exists("selected_slot")) {
    global.selected_slot = 1; // Default to the first save slot
}

if (!variable_instance_exists(id, "message_text")) {
    message_text = "";  // Initialize message_text as an empty string
}

if (!variable_instance_exists(id, "weapon_text")) {
    weapon_text = "";  // Initialize message_text as an empty string
}

if (!variable_global_exists("show_equip")) {
    global.show_equip = false;
}

if (!variable_global_exists("selected_weapon_index")) {
    global.selected_weapon_index = 0; // Default selected weapon index
}

if (!variable_global_exists("selected_party_member_index")) {
    global.selected_party_member_index = 0; // Default selected party member index
}

just_entered_confirmation = false;
