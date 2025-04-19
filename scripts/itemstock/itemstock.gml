function get_item_stock(item) {
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i][0] == item) {
            return global.inventory[i][1];  // Return the stock count
        }
    }
    return 0;  // Return 0 if the item is not found
}


function purchase_item(index) {
    var item_entry = items_for_sale[index];
    var item_price = item_entry.price;

    // Check if player has enough money and the item is in stock
    if (global.totalMoney >= item_price) {
        // Reduce stock
        for (var i = 0; i < array_length(global.inventory); i++) {
            if (global.inventory[i][0] == item_entry.item) {
                global.inventory[i][1]++;  // Increment stock count
                global.totalMoney -= item_price;  // Deduct the cost
                break;
            }
        }
    } else {
        show_message("Not enough gold!");
    }
}


// Function to get the stock count of a weapon
function get_weapon_stock(weapon) {
    for (var i = 0; i < array_length(global.weaponInventory); i++) {
        if (global.weaponInventory[i][0] == weapon) {
            return global.weaponInventory[i][1];  // Return the stock count
        }
    }
    return 0;  // Return 0 if the weapon is not found
}

// Function to handle weapon purchases
function purchase_weapon(index) {
    var weapon_entry = weapons_for_sale[index];
    var weapon_price = weapon_entry.price;

    // Check if player has enough money and the weapon is in stock
    if (global.totalMoney >= weapon_price) {
        // Reduce stock
        for (var i = 0; i < array_length(global.weaponInventory); i++) {
            if (global.weaponInventory[i][0] == weapon_entry.weapon) {
                global.weaponInventory[i][1] += 1;  // Increment stock count
                global.totalMoney -= weapon_price;  // Deduct the cost
                break;
            }
        }
    } else {
        show_message("Not enough gold!");
    }
}
