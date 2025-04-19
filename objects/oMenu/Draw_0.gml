// draw event in oMenu
draw_sprite_stretched(sBox, 0, x, y + 15, widthFull + 15, heightFull);
draw_set_colour(c_white);
draw_set_font(fnM5x7);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var _desc = !(description == -1);
var _scrollPush = max(0, hover - (visibleOptionsMax - 1));

for (var l = 0; l < (visibleOptionsMax + _desc); l++) {
    if (l >= array_length(options)) break;
    draw_set_colour(c_white);
    if (l == 0 && _desc) {
        draw_text(x + xmargin, y + ymargin + 15, description);
    } else {
        var _optionToShow = l - _desc + _scrollPush;
        var _str = options[_optionToShow][0];
        if (hover == _optionToShow - _desc) {
            draw_set_colour(c_yellow);
        }
        if (options[_optionToShow][3] == false) draw_set_colour(c_gray);
        draw_text(x + xmargin, y + ymargin + l * heightLine + 15, _str);
    }
}

// Draw additional info box at a fixed position only if there’s data to show
if (hover >= 0 && hover < array_length(options)) {
    var _option = options[hover];

    // Safely retrieve elements to avoid out-of-bounds errors
    var _mpCost = array_length(_option) > 4 ? _option[4] : "";
    var _damageRange = array_length(_option) > 5 ? _option[5] : "";
    var _healRange = array_length(_option) > 6 ? _option[6] : "";
    var _mpRange = array_length(_option) > 7 ? _option[7] : "";
    var _info = array_length(_option) > 8 ? _option[8] : "";

    // Check if the current submenu is "Item"
    var isItemMenu = (_option[1] == MenuSelectAction && _option[2][1].subMenu == "Item");

    // Set up the info box dimensions
    var infoBoxWidth = 120;
    var infoBoxHeight = isItemMenu ? 60 : 60;  // Smaller height if only description for items
    var infoBoxX = x + widthFull + 15;
    var infoBoxY = y + 15;

    // Check if there’s relevant data to display in the info box
    var showInfoBox = (_damageRange != "" || _mpCost != "" || _healRange != "" || _mpRange != "" || _info != "");

    // Only draw the info box if there’s relevant data to display
    if (showInfoBox) {
        // Draw the info box background
        draw_sprite_stretched(sBox, 0, infoBoxX, infoBoxY, infoBoxWidth, infoBoxHeight);
        draw_set_colour(c_white);

        // Display the action information (damage, MP cost, heal, MP restore, etc.)
        if (isItemMenu) {
            // Only display description for items
            draw_text(infoBoxX + 5, infoBoxY - 5, " " + _mpCost);
        } else {
            if (_damageRange != "") {
                draw_text(infoBoxX + 5, infoBoxY + 5, "Damage: " + _damageRange);
            }
            if (_mpCost != "") {
                draw_text(infoBoxX + 5, infoBoxY + 15, "MP Cost: " + string(_mpCost));
            }
            if (_healRange != "") {
                draw_text(infoBoxX + 5, infoBoxY + 5, "Heal: " + _healRange);
            }
            if (_mpRange != "") {
                draw_text(infoBoxX + 5, infoBoxY + 5, "MP Restore: " + _mpRange);
            }
            if (_info != "") {
                draw_text(infoBoxX + 5, infoBoxY + 25, "" + _info);
            }
        }
    }
}

// Draw the pointer
draw_sprite(sPointer, 0, x + xmargin + 8, y + ymargin + ((hover - _scrollPush) * heightLine) + 22);

// Draw the scroll arrow if there are more options than visible
if (visibleOptionsMax < array_length(options) && hover < array_length(options) - 1) {
    draw_sprite_stretched(sDownArrow, -1, x + widthFull * 0.5, y + heightFull, 15, 15);
}
