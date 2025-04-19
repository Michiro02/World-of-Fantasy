function DropItem(_enemy) {
    var drops = _enemy.drops;
    var droppedItems = [];
    for (var i = 0; i < array_length(drops); i++) {
        if (random(100) < drops[i].chance) {
            AddItemToInventory(drops[i].item, 1);
            var itemName = drops[i].item.name; // Initialize itemName here
            show_debug_message("Dropping item: " + itemName); // Debug message

            // Check if item already dropped
            var existingItemIndex = -1;
            for (var j = 0; j < array_length(droppedItems); j++) {
                if (droppedItems[j].name == itemName) {
                    existingItemIndex = j;
                    break;
                }
            }

            if (existingItemIndex == -1) {
                show_debug_message("Item not found, adding new item: " + itemName); // Debug message
                array_push(droppedItems, { name: itemName, amount: 1 });
            } else {
                show_debug_message("Item found, increasing amount: " + itemName); // Debug message
                droppedItems[existingItemIndex].amount++;
            }
        }
    }
    show_debug_message("Dropped Items: " + string(droppedItems)); // Debug message
    return droppedItems;
}



function AddItemToInventory(_item, _amount) {
    var itemExists = false;
    for (var i = 0; i < array_length(global.inventory); i++) {
        if (global.inventory[i][0] == _item) {
            global.inventory[i][1] += _amount;
            itemExists = true;
            break;
        }
    }
    if (!itemExists) {
        array_push(global.inventory, [_item, _amount]);
    }
}

