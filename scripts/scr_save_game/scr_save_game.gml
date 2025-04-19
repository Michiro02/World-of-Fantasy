function scr_save_game(slot, is_ending_credits = false) {
    var filename = "savegame" + string(slot) + ".txt";
    var file = file_text_open_write(filename);

    // Save current date and time
    var save_date = scr_get_current_datetime();
    file_text_write_string(file, save_date);
    file_text_writeln(file);

    // Save player position and room index
    if (is_ending_credits) {
        // Save fixed position in the desert room (for ending credits)
        file_text_write_real(file, 258); // Example X position in desert room
        file_text_writeln(file);
        file_text_write_real(file, 342); // Example Y position in desert room
        file_text_writeln(file);
        file_text_write_real(file, asset_get_index("Desert")); // Desert room index
        file_text_writeln(file);

        // Save room name
        var room_name = "Desert"; // Desert room
        file_text_write_string(file, room_name);
        file_text_writeln(file);
    } else {
        // Save the player's current position (for normal gameplay)
        if (instance_exists(oPlayer)) {
            file_text_write_real(file, oPlayer.x);
            file_text_writeln(file);
            file_text_write_real(file, oPlayer.y);
            file_text_writeln(file);
            file_text_write_real(file, room); // Current room index
            file_text_writeln(file);

            // Save room name
            var room_name = room_get_name(room);
            file_text_write_string(file, room_name);
            file_text_writeln(file);
        } else {
            // If the player object doesn't exist, save default values
            file_text_write_real(file, 248); // Default X position
            file_text_writeln(file);
            file_text_write_real(file, 342); // Default Y position
            file_text_writeln(file);
            file_text_write_real(file, asset_get_index("Desert")); // Default room index
            file_text_writeln(file);

            // Save default room name
            var room_name = "Desert"; // Default room
            file_text_write_string(file, room_name);
            file_text_writeln(file);
        }
    }

    // Save global money
    file_text_write_real(file, global.totalMoney);
    file_text_writeln(file);

    // Save player's level
    var player_level = global.party[0].level; 
    file_text_write_real(file, player_level);
    file_text_writeln(file);

    // Save item inventory
    file_text_write_real(file, array_length(global.inventory)); // Save number of items
    file_text_writeln(file);

    for (var i = 0; i < array_length(global.inventory); i++) {
        var item_obj = global.inventory[i][0]; // Get item object
        var quantity = global.inventory[i][1]; // Get quantity

        var item_key = "";
        var keys = variable_struct_get_names(global.actionLibrary); // Get the keys from actionLibrary
        for (var j = 0; j < array_length(keys); j++) {
            var key = keys[j];
            if (global.actionLibrary[$ key] == item_obj) {
                item_key = key;
                break;
            }
        }

        // Write item key and quantity to file
        file_text_write_string(file, item_key);
        file_text_writeln(file);
        file_text_write_real(file, quantity);
        file_text_writeln(file);
    }

    // Save party members' data 
    for (var i = 0; i < array_length(global.party); i++) {
        var party_member = global.party[i];
        file_text_write_string(file, party_member.name);
        file_text_writeln(file);
        file_text_write_real(file, party_member.level);
        file_text_writeln(file);
        file_text_write_real(file, party_member.strength);
        file_text_writeln(file);
        file_text_write_real(file, party_member.magic);
        file_text_writeln(file);
        file_text_write_real(file, party_member.baseHpMax); 
        file_text_writeln(file);
        file_text_write_real(file, party_member.baseMpMax); 
        file_text_writeln(file);
        file_text_write_real(file, party_member.hpMax);
        file_text_writeln(file);
        file_text_write_real(file, party_member.mpMax);
        file_text_writeln(file);
        file_text_write_real(file, party_member.hp);
        file_text_writeln(file);
        file_text_write_real(file, party_member.mp);
        file_text_writeln(file);
        file_text_write_real(file, party_member.xp);
        file_text_writeln(file);
        file_text_write_real(file, party_member.xpNext);
        file_text_writeln(file);

        // Save party member's skills
        file_text_write_real(file, array_length(party_member.actions)); 
        file_text_writeln(file);
        for (var j = 0; j < array_length(party_member.actions); j++) {
            var skill_key = "";
            var keys = variable_struct_get_names(global.actionLibrary);
            for (var k = 0; k < array_length(keys); k++) {
                var key = keys[k];
                if (global.actionLibrary[$ key] == party_member.actions[j]) {
                    skill_key = key;
                    break;
                }
            }
            file_text_write_string(file, skill_key);
            file_text_writeln(file);
        }
    }

    // Save weapon inventory 
    file_text_write_real(file, array_length(global.weaponInventory));
    file_text_writeln(file);
    for (var i = 0; i < array_length(global.weaponInventory); i++) {
        var weapon_obj = global.weaponInventory[i][0];
        var quantity = global.weaponInventory[i][1];

        var weapon_key = "";
        var keys = variable_struct_get_names(global.weaponLibrary);
        for (var j = 0; j < array_length(keys); j++) {
            var key = keys[j];
            if (global.weaponLibrary[$ key] == weapon_obj) {
                weapon_key = key;
                break;
            }
        }

        file_text_write_string(file, weapon_key);
        file_text_writeln(file);
        file_text_write_real(file, quantity);
        file_text_writeln(file);
    }
	
    // Save equipped weapon for each party member
    for (var i = 0; i < array_length(global.party); i++) {
        var party_member = global.party[i];

        if (party_member.equippedWeapon != undefined) {
            // Save the equipped weapon key
            var weapon_key = "";
            var keys = variable_struct_get_names(global.weaponLibrary);
            for (var j = 0; j < array_length(keys); j++) {
                var key = keys[j];
                if (global.weaponLibrary[$ key] == party_member.equippedWeapon) {
                    weapon_key = key;
                    break;
                }
            }
            file_text_write_string(file, weapon_key);
            file_text_writeln(file);
        } else {
            // If no weapon is equipped, write a placeholder
            file_text_write_string(file, "none");
            file_text_writeln(file);
        }
    }

    // Save side quest flags
    file_text_write_real(file, global.dog_found);
    file_text_writeln(file);
    file_text_write_real(file, global.dog_reward_given);
    file_text_writeln(file);
	
	// Save the state of Defeated
    file_text_write_real(file, global.cerberusDefeated);
    file_text_writeln(file);
	
	file_text_write_real(file, global.bossDefeated);
    file_text_writeln(file);
	
	file_text_write_real(file, global.gigatoaDefeated);
    file_text_writeln(file);
	
	file_text_write_real(file, global.fourfiendsDefeated);
    file_text_writeln(file);
	
	file_text_write_real(file, global.BahamutDefeated);
    file_text_writeln(file);
	
	file_text_write_real(file, global.LeviathanDefeated);
    file_text_writeln(file);
			
    file_text_close(file);
}