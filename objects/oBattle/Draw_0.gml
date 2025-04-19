// Draw Event
// Draw background art
draw_sprite(battleBackground, 0, x, y);

// Draw units in depth order
var _unitWithCurrentTurn = unitTurnOrder[turn].id;
for (var i = 0; i < array_length(unitRenderOrder); i++) {
    with (unitRenderOrder[i]) {

        draw_self();
        if (id == _unitWithCurrentTurn) && (!enemy) && (instance_exists(oMenu)) draw_sprite(sTurnIndicator, 0, x, y);
    }
}

// Draw the transitioning enemies separately
if (transitionActive) {
    // Draw recent enemy
    draw_sprite_ext(transitionEnemy.sprite_index, 0, transitionEnemy.x, transitionEnemy.y, transitionEnemy.image_xscale, 1, 0, c_white, 1);

    // Draw new enemy
    if (transitionNewEnemy != noone) {
        draw_sprite_ext(transitionNewEnemy.sprites.idle, 0, transitionNewEnemy.x, transitionNewEnemy.y, transitionNewEnemy.image_xscale, 1, 0, c_white, 1);
    }
}


// Boss HP Bar Section (for specific enemy)
//for (var i = 0; i < array_length(enemyUnits); i++) {
  //  var _enemy = enemyUnits[i];
    
    
//    if ((_enemy.name == "Gigatoa" || _enemy.name == "Sephiroth") && _enemy.hp > 0) {
        // Position and size of the HP bar
 //       var barX = x + 220; // X position of the bar
 //       var barY = y + 130; // Y position of the bar
//        var barWidth = 80; // Total width of the bar
 //       var barHeight = 20; // Height of the bar

        // Calculate HP percentage (with decimals)
//        var hpPercentage = (_enemy.hp / _enemy.hpMax) * 100;
//        var percentageText = string_format(hpPercentage, 0, 2) + "%"; // Format to 2 decimal places

        // Draw the background of the HP bar
//        draw_set_color(c_black);
  //      draw_rectangle(barX, barY, barX + barWidth, barY + barHeight, false);

        // Draw the foreground of the HP bar (current HP)
    //    draw_set_color(c_red);
      //  draw_rectangle(barX, barY, barX + (barWidth * (hpPercentage / 100)), barY + barHeight, false);

        // Draw a border around the HP bar
        //draw_set_color(c_white);
        //draw_rectangle(barX, barY, barX + barWidth, barY + barHeight, true);

        // Draw boss name and precise HP percentage
        //draw_set_font(fnDialogue); // Ensure the font is set
        //draw_set_color(c_white);
        //draw_set_halign(fa_center); // Align horizontally
        //draw_set_valign(fa_middle); // Align vertically

        // Draw centered HP text (centered within the bar)
      //  draw_text(barX + (barWidth / 2), barY + (barHeight / 2), percentageText);

     //   break; // Stop the loop after finding the specific boss
   // }
//}

//Positions
#macro COLUMN_ENEMY 15
#macro COLUMN_NAME 90
#macro COLUMN_HP 160
#macro COLUMN_MP 220

draw_sprite_stretched(sBox,0,x+75,y+165,245,80);
draw_sprite_stretched(sBox,0,x,y+165,80,80);

//Draw headings
draw_set_font(fnDialogue);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_text(x+COLUMN_ENEMY,y+172,"ENEMY");
draw_text(x+COLUMN_NAME,y+172,"NAME");
draw_text(x+COLUMN_HP + 10,y+172,"HP");
draw_text(x+COLUMN_MP + 20,y+172,"MP");

draw_set_font(fnDialogue);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);

//Draw enemy names
var _drawLimit = 4;
var _drawn = 0;
for (var i = 0; (i < array_length(enemyUnits)) && (_drawn < _drawLimit); i++)
{
	var _char = enemyUnits[i];
	if (_char.hp > 0)
	{
		_drawn++;
		draw_set_halign(fa_left);
		draw_set_color(c_white);
		if (_char.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
		draw_text(x-13+COLUMN_ENEMY,y+185+(i*12),_char.name);
	}
}

//Draw party info
for (var i = 0; i < array_length(partyUnits); i++)
{
	draw_set_halign(fa_left);
	draw_set_color(c_white);
	var _char = partyUnits[i];
	if (_char.id == _unitWithCurrentTurn) draw_set_color(c_yellow);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_NAME,y+185+(i*12),_char.name);
	draw_set_halign(fa_right);
	
	draw_set_color(c_white);
	if (_char.hp < (_char.hpMax * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_HP+50,y+185+(i*12),string(_char.hp) + "/" + string(_char.hpMax));
	
	draw_set_color(c_white);
	if (_char.mp < (_char.mpMax * 0.5)) draw_set_color(c_orange);
	if (_char.hp <= 0) draw_set_color(c_red);
	draw_text(x+COLUMN_MP+60,y+185+(i*12),string(_char.mp) + "/" + string(_char.mpMax));
	
	draw_set_color(c_white);
}

if (targetCursor.cursorActive)
{
	with (targetCursor)
	{
		if (cursorTarget != noone) 
		{
			if (is_array(cursorTarget))
			{
				draw_set_alpha(sin(get_timer()/50000)+1);
				for (var i = 0; i < array_length(cursorTarget); i++)
				{
					draw_sprite(sPointer,cursorError,cursorTarget[i].x,cursorTarget[i].y - 5);
				}
				draw_set_alpha(1.0);
			}
			else draw_sprite(sPointer,cursorError,cursorTarget.x,cursorTarget.y - 5);
		}
	}
}

//Draw battle text
if (battleText != "")
{
	var _w = string_width(battleText)+20;
	draw_sprite_stretched(sBox,0,x+160-(_w*0.5),y+5,_w,25);
	draw_set_halign(fa_center);
	draw_set_color(c_white);
	draw_text(x+160,y+15,battleText);
	
	//Continue arrow for multi message
	if (battleState == 2) 
	{
		draw_set_alpha(sin(get_timer()/50000)+1);
		draw_sprite(sDownArrow,0,x + 160, y + 32);
		draw_set_alpha(1.0);
	}
	
	draw_set_halign(fa_left);
}

// Check if `currentUser` exists and is silenced
// Loop through each character in partyUnits
for (var i = 0; i < array_length(partyUnits); i++) 
{
	image_speed = 0.2;
    var character = partyUnits[i];
	
	

    // Only draw the paralysis icon if the character is alive
	if (character.hp > 0 && variable_instance_exists(character, "paralyzed") && character.paralyzed) 
	{
	    var icon_x = character.x;
	    var icon_y = character.y;  
	    draw_sprite_ext(sParalyze_1, -1, icon_x, icon_y, 1, 1, 0, c_white, 0.8 + 0.2 * sin(current_time / 200));
	}
}

// Draw "Assess" info if viewing
if (global.assessViewing && global.assessInfo != noone)
{
    var _info = global.assessInfo;

    var _boxX = x + 30;  
    var _boxY = y + 30;   
    var _boxW = 270;      
    var _boxH = 160;  // Fixed height (does NOT expand)

    // Set up default spacing
    var _lineSpacing = 15; 
    var _textX = _boxX + 10;
    var _textY = _boxY + 50;

    // HANDLE SPRITE SCALING
    var spriteScale = 1.0; // Default scale
    var maxSpriteWidth = 50;  
    var maxSpriteHeight = 50; 

    var spriteW = sprite_get_width(_info.sprite);
    var spriteH = sprite_get_height(_info.sprite);

    if (spriteW > maxSpriteWidth || spriteH > maxSpriteHeight) {
        var scaleX = maxSpriteWidth / spriteW;
        var scaleY = maxSpriteHeight / spriteH;
        spriteScale = min(scaleX, scaleY); 
    }

    // TEXT WRAPPING FUNCTION (Truncate if text is too long)
    function wrapText(_text, _maxWidth, _maxLines) {
        if (_text == "None") return ["None"]; 

        var _words = string_split(_text, ", ");
        var _lines = [];
        var _line = "";

        for (var i = 0; i < array_length(_words); i++) {
            var _testLine = _line + (_line != "" ? ", " : "") + _words[i];

            if (string_width(_testLine) > _maxWidth) {
                if (_line != "") array_push(_lines, _line);
                _line = _words[i]; 

                if (array_length(_lines) >= _maxLines) {
                    array_push(_lines, "..."); // Indicate truncated text
                    return _lines;
                }
            } else {
                _line = _testLine;
            }
        }

        if (_line != "") array_push(_lines, _line);
        return _lines;
    }

    // DRAW UI BACKGROUND
    draw_set_color(c_black);
    draw_rectangle(_boxX, _boxY, _boxX + _boxW, _boxY + _boxH, false);
    
    // Border
    draw_set_color(c_white);
    draw_rectangle(_boxX, _boxY, _boxX + _boxW, _boxY + _boxH, true);

    // Draw sprite (Scaled)
    draw_sprite_ext(_info.sprite, 0, _boxX + 28, _boxY + 25, spriteScale, spriteScale, 0, c_white, 1.0);

    // DRAW TEXT INFO
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    draw_text(_boxX + 60, _boxY + 10, "Name: " + _info.name);
    draw_text(_boxX + 60, _boxY + 25, "HP: " + string(_info.hp) + "/" + string(_info.hpMax));

    var _textMaxWidth = _boxW - 30; 
    var _maxLines = 2; // Limit the number of lines for each section

    // Weaknesses
    draw_text(_textX, _textY, "Weak:");
    var _weaknessLines = wrapText(formatArray(_info.weaknesses), _textMaxWidth, _maxLines);
    _textY += _lineSpacing;
    for (var i = 0; i < array_length(_weaknessLines); i++) {
        draw_text(_textX + 50, _textY - 15, _weaknessLines[i]);
        _textY += _lineSpacing;
    }

    // Absorbs
    draw_text(_textX, _textY, "Absorb:");
    var _absorbLines = wrapText(formatArray(_info.absorbs), _textMaxWidth, _maxLines);
    _textY += _lineSpacing;
    for (var i = 0; i < array_length(_absorbLines); i++) {
        draw_text(_textX + 50, _textY - 15, _absorbLines[i]);
        _textY += _lineSpacing;
    }

    // Resistances
    draw_text(_textX, _textY, "Resist:");
    var _resistLines = wrapText(formatArray(_info.resistances), _textMaxWidth, _maxLines);
    _textY += _lineSpacing;
    for (var i = 0; i < array_length(_resistLines); i++) {
        draw_text(_textX + 50, _textY- 15, _resistLines[i]);
        _textY += _lineSpacing;
    }

    // FIXED POSITION FOR "Press Enter to continue"
    var _exitTextY = _boxY + _boxH - 20; // Fixed at bottom
    draw_text(_boxX + 70, _exitTextY + 10, "[Press Enter to continue]");

    // EXIT ASSESSMENT MODE
    if (keyboard_check_pressed(vk_enter))
    {
        global.assessViewing = false; // Close the assessment window
        global.assessInfo = noone; // Clear the assessed data
        BattleStateTurnProgression(); // Resume turn progression
    }
}

if (levelDisplay) {
    var posX = x + 90; // Adjusted for screen placement
    var posY = y + 10;
    var width = 200; // Width of borders
    var height = 40;
    var padding = 5;

    draw_set_font(fnDialogue_3);

    // FIRST BORDER: Total Gil & EXP
    draw_set_color(c_black);
    draw_rectangle(posX, posY, posX + width, posY + height, false);
    draw_set_color(c_white);
    draw_rectangle(posX, posY, posX + width, posY + height, true);
    draw_text(posX + 10, posY + 10, "Money: " + string(global.totalMoneyGained));
    draw_text(posX + 10, posY + 30, "EXP: " + string(battleXpGained));

    posY += height + padding;

    // Check if any character leveled up to 110 in this battle
    var leveledUpToMax = false;
    for (var i = 0; i < array_length(global.levelUpSummary); i++) {
       if (global.levelUpSummary[i].newLevel > global.levelUpSummary[i].prevLevel) {
            leveledUpToMax = true;
            global.justReachedMaxLevel = true;
            break;
        }
    }

    // Only draw SECOND BORDER if a character leveled up to 110 in this battle
    if (leveledUpToMax) {
        // SECOND BORDER: Party EXP & Level-Ups
        draw_set_color(c_black);
        draw_rectangle(posX, posY, posX + width, posY + 100, false);
        draw_set_color(c_white);
        draw_rectangle(posX, posY, posX + width, posY + 100, true);

        // Display logic for SECOND BORDER
        if (global.levelUpSummaryStep == 0) {
            // PHASE 1: Show all names of characters who leveled up
            for (var i = 0; i < array_length(global.levelUpSummary); i++) {
                var summary = global.levelUpSummary[i];
                draw_text(posX + 10, posY + 10 + (i * 20), summary.name + " Leveled Up!");
            }
        } else {
            // PHASE 2: Show only one character's stats at a time
            var idx = global.levelUpSummaryStep - 1; // Adjust step to match array index

            // ✅ Fix: Ensure idx does not exceed valid range
            if (idx >= 0 && idx < array_length(global.levelUpSummary)) {
                var summary = global.levelUpSummary[idx];

                // Draw the stats for the current player
                draw_text(posX + 10, posY + 10, summary.name + " Leveled Up!");
                draw_text(posX + 10, posY + 30, "Lv: " + string(summary.prevLevel) + " -> " + string(summary.newLevel));
                draw_text(posX + 10, posY + 45, "HP: " + string(summary.prevHp) + " -> " + string(summary.newHp));
                draw_text(posX + 10, posY + 60, "MP: " + string(summary.prevMp) + " -> " + string(summary.newMp));
                draw_text(posX + 10, posY + 75, "Str: " + string(summary.prevStrength) + " -> " + string(summary.newStrength));
                draw_text(posX + 10, posY + 90, "Mag: " + string(summary.prevMagic) + " -> " + string(summary.newMagic));
            }
        }

        posY += 100 + padding;
    }

    // THIRD BORDER: Item Drops or Learned Skill
    draw_set_color(c_black);
    draw_rectangle(posX, posY, posX + width, posY + 60, false);
    draw_set_color(c_white);
    draw_rectangle(posX, posY, posX + width, posY + 60, true);

    var dropY = posY + 5;

    if (global.levelUpSummaryStep == 0) {
        // PHASE 1: Show item drops
        if (global.showItemDrops == 0) {
            for (var i = 0; i < array_length(global.droppedItems); i++) {
                var item = global.droppedItems[i];
                draw_text(posX + 10, dropY, "Obtained: " + item.name + " x" + string(item.amount));
                dropY += 10;
            }
        }
    } else {
        // PHASE 2: Show learned skills for the current player
        var idx = global.levelUpSummaryStep - 1;
        if (idx >= 0 && idx < array_length(global.levelUpSummary)) {
            var summary = global.levelUpSummary[idx];
            var playerName = summary.name;

            // Check if this player has learned any skills
            if (array_length(global.lastLearnedSkills) > 0) {
                for (var i = 0; i < array_length(global.lastLearnedSkills); i++) {
                    var skillEntry = global.lastLearnedSkills[i];

                    // Check if the skill entry belongs to the current player
                    if (string_pos(playerName, skillEntry) > 0) {
                        // Extract the skill name from the entry
                        var skillName = string_copy(skillEntry, string_length(playerName + " learned ") + 1, string_length(skillEntry));

                        // Draw the skill name
                        draw_text(posX + 10, dropY, "Learned: " + skillName);
                        dropY += 10; // Move to next line for multiple skills
                    }
                }
            }
        }
    }
}