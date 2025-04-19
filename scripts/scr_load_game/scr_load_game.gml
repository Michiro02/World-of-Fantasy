function scr_load_game() {
    var slot = argument0;
    var filename = "savegame" + string(slot) + ".txt";

    if (file_exists(filename)) {
        var file = file_text_open_read(filename);

        // Read save date
        var save_date = file_text_read_string(file);
        file_text_readln(file);

        // Load player position
        oPlayer.x = file_text_read_real(file);
        file_text_readln(file);
        oPlayer.y = file_text_read_real(file);
        file_text_readln(file);

        // Load room index
        var target_room = file_text_read_real(file);
        file_text_readln(file);

        // Load room name
        var room_name = file_text_read_string(file);
        file_text_readln(file);

        // Load global money
        global.totalMoney = file_text_read_real(file);
        file_text_readln(file);

        // Load player's level
        global.party[0].level = file_text_read_real(file);
        file_text_readln(file);


		    // Load item inventory
		   var item_count = file_text_read_real(file); // Get number of items
		   file_text_readln(file);
		   global.inventory = []; // Clear the current inventory

	    for (var i = 0; i < item_count; i++) {
        var item_key = file_text_read_string(file); // Read item key
	    file_text_readln(file);
	    var quantity = file_text_read_real(file); // Read item quantity
	    file_text_readln(file);

	    var item_obj = global.actionLibrary[$ item_key]; // Get the actual item object
	    array_push(global.inventory, [item_obj, quantity]); // Add item and quantity to inventory
	    }


        // Load party members' data
        for (var i = 0; i < array_length(global.party); i++) {
            var party_member = global.party[i];
           party_member.name = file_text_read_string(file);
            file_text_readln(file);
            party_member.level = file_text_read_real(file);
            file_text_readln(file);
            party_member.strength = file_text_read_real(file);
            file_text_readln(file);
            party_member.magic = file_text_read_real(file);
            file_text_readln(file);
            party_member.baseHpMax = file_text_read_real(file); // Load baseHpMax
            file_text_readln(file);
            party_member.baseMpMax = file_text_read_real(file); // Load baseMpMax
            file_text_readln(file);
            party_member.hpMax = file_text_read_real(file);
            file_text_readln(file);
            party_member.mpMax = file_text_read_real(file);
            file_text_readln(file);
            party_member.hp = file_text_read_real(file);
            file_text_readln(file);
            party_member.mp = file_text_read_real(file);
            file_text_readln(file);
            party_member.xp = file_text_read_real(file);
            file_text_readln(file);
            party_member.xpNext = file_text_read_real(file);
            file_text_readln(file);

            // Load party member's skills
            var skill_count = file_text_read_real(file);
            file_text_readln(file);
            party_member.actions = [];
            for (var j = 0; j < skill_count; j++) {
                var skill_key = file_text_read_string(file);
                file_text_readln(file);
                var skill = global.actionLibrary[$ skill_key];
                array_push(party_member.actions, skill);
            }
        }

        // Load weapon inventory
        var weapon_count = file_text_read_real(file);
        file_text_readln(file);
        global.weaponInventory = [];
        for (var i = 0; i < weapon_count; i++) {
            var weapon_key = file_text_read_string(file);
            file_text_readln(file);
            var quantity = file_text_read_real(file);
            file_text_readln(file);

            var weapon_obj = global.weaponLibrary[$ weapon_key];
            array_push(global.weaponInventory, [weapon_obj, quantity]);
        }
		
		// Load equipped weapon for each party member
for (var i = 0; i < array_length(global.party); i++) {
    var party_member = global.party[i];

    var weapon_key = file_text_read_string(file);
    file_text_readln(file);

    if (weapon_key != "none") {
        var weapon_obj = global.weaponLibrary[$ weapon_key];
        party_member.equippedWeapon = weapon_obj;

        // Remove the weapon from inventory since it's equipped
        RemoveWeaponFromInventory(weapon_obj, 1);
    } else {
        party_member.equippedWeapon = undefined;
    }
}


        // Load side quest flags
        global.dog_found = file_text_read_real(file);
        file_text_readln(file);
        global.dog_reward_given = file_text_read_real(file);
        file_text_readln(file);
		
		 // Load the state of Defeated
        global.cerberusDefeated = file_text_read_real(file);
        file_text_readln(file);
		
		global.bossDefeated = file_text_read_real(file);
        file_text_readln(file);
		
		global.gigatoaDefeated = file_text_read_real(file);
        file_text_readln(file);
		
		global.fourfiendsDefeated = file_text_read_real(file);
        file_text_readln(file);
		
		global.BahamutDefeated = file_text_read_real(file);
        file_text_readln(file);
		
		global.LeviathanDefeated = file_text_read_real(file);
        file_text_readln(file);
		
        file_text_close(file);

        // Go to the saved room
        room_goto(target_room);

        // Ensure the game remains unpaused after loading
        global.game_paused = false;

        // Recreate the pause menu
        instance_create_layer(oPlayer.x, oPlayer.y, "GUI", oPauseMenu);
    }
}
