//Transition setup
transitionProg = 0;
surfTransition = surface_create(surface_get_width(application_surface),surface_get_height(application_surface));
surface_copy(surfTransition,0,0,application_surface);
instance_deactivate_all(true);

//Battle setup
global.extraTurnActive = false; // Track if an extra turn is in progress
global.enemyExtraTurnUsed = 0;
global.deathDialogueQueue = [];
global.assessInfo = noone; // Default value
global.assessViewing = false; // Controls if Assess UI is active
global.droppedItems = [];
global.showItemDrops = false;
transitionActive = false; // Whether a transition is currently active
transitionTimer = 0; // Timer for the transition
transitionEnemy = noone; // The enemy being transitioned out
transitionNewEnemy = noone; // The new enemy being transitioned in
transitionStartY = 0; // Starting Y position for the transition
transitionEndY = 0; // Ending Y position for the transition 
levelDisplay = false;
damageTextDisplayed = false;
battleWaitForMenu = false
battleWaitTimeFrames = 45; //time to wait before finishing an action or turn
battleWaitTimeRemaining = 0;
battleText = "";
battleEndMessageProg = 0;
battleEndMessages = [];
battleXpGained = 0;
conclusionType = -1;
escaped = false;
turn = 0;
turnCount = 0;
roundCount = 0;
units = [];
unitTurnOrder = [];
unitRenderOrder = [];
unitDepth = depth-10;


//Make party
for (var i = 0; i < array_length(global.party); i++)
{
	partyUnits[i] = instance_create_depth(x+70-(i*10),y+55+(i*15),unitDepth,oBattleUnitPC,global.party[i]);
	array_push(units, partyUnits[i]);
}

// Make enemies
var total_enemies = array_length(enemies);

for (var i = 0; i < total_enemies; i++)
{
    if (total_enemies == 1) {
       
        enemyUnits[i] = instance_create_depth(x+255, y+88, unitDepth, oBattleUnitEnemy, enemies[i]);
    } 
    else if (total_enemies == 2) {
       
        enemyUnits[i] = instance_create_depth(x+250, y+68 + (i * 40), unitDepth, oBattleUnitEnemy, enemies[i]);
    } 
    else {
       
        enemyUnits[i] = instance_create_depth(x+250+((i mod 3)*10)+((i div 3)*45), y+58+((i mod 3)*30), unitDepth, oBattleUnitEnemy, enemies[i]);
    }
    array_push(units, enemyUnits[i]);
}



//Make cursorTarget cursor
targetCursor = 
{
	cursorUser: noone,
	cursorTarget: noone,
	cursorAction : -1,
	cursorSide : -1, 
	cursorIndex : 0,
	cursorError : false,
	cursorConfirmDelay : 0,
	cursorActive : false,
	cursorAll : 0 //0: single, 1: all
};


//Shuffle turn order
unitTurnOrder = array_shuffle(units);

//Get render order
RefreshRenderOrder = function()
{
	unitRenderOrder = [];
	array_copy(unitRenderOrder,0,units,0,array_length(units));
	array_sort(unitRenderOrder,function(_1, _2)
	{
		return _1.y - _2.y;
	});
}
RefreshRenderOrder();


function BeginAction(_user, _action, _targets)
{
    battleState = BattleStatePerformAction;
    currentUser = _user;
    currentAction = _action;
    currentTargets = _targets;
    
    // Ensure targets are in an array format, but also check if targets are invalid (like -1 for self-actions)
    if (!is_array(currentTargets)) currentTargets = (_targets != -1) ? [_targets] : [];

    // Prepare the battle text
    var targetNames = "";
    if (array_length(currentTargets) > 0) {
        // Handle multiple targets
        for (var i = 0; i < array_length(currentTargets); i++) {
            targetNames += currentTargets[i].name; // Append target's name
            if (i < array_length(currentTargets) - 1) {
                targetNames += ", "; // Add comma between multiple targets
            }
        }
    } else {
        // If no targets, use a generic text for self-actions like "Defend"
        targetNames = "self"; // You can customize this message if needed
    }
    
   // Update the battleText to include the attacker, target(s), and the countdown
	battleText = string_ext(_action.description, [_user.name, targetNames, string(global.Countdown)]);
	
    battleWaitTimeRemaining = battleWaitTimeFrames;
    
    // Check if userAnimation exists before attempting to set the sprite
    with (_user)
    {
        acting = true;
        if (!is_undefined(_action.subMenu) && _action.subMenu == "Item")
        {
            RemoveItemFromInventory(_action, 1);
        }
        
        // Check if the action has an animation defined
        if (variable_struct_exists(_action, "userAnimation") && !is_undefined(_action.userAnimation) && !is_undefined(_user.sprites[$ _action.userAnimation]))
        {
            sprite_index = sprites[$ _action.userAnimation];
            image_index = 0;
        }
    }
}
	

function BattleStateSelectAction()
{
    if (!instance_exists(oMenu))
    {
        var _unit = unitTurnOrder[turn];

        // Is this unit alive and able to act?
        if (instance_exists(_unit) && (_unit.hp > 0))
        {
            // Reset any one turn effects
            _unit.defending = false;
			
			 // Display the current unit's name
            battleText = string(_unit.name) + "'s turn!";
            battleWaitTimeRemaining = battleWaitTimeFrames;
            // Player
            if (_unit.enemy == false)
            {
                // Compile the action menu
                var _menuOptions = [];
                var _subMenus = {};

                // Add inventory to action list
                var _inventoryActions = [];
                for (var i = 0; i < array_length(global.inventory); i++)
                {
                    // If we have any of this item left we want to add them to the action list
                    if (global.inventory[i][1] > 0)	
                    {
                        var _itemAction = global.inventory[i][0];
                        _itemAction.count = global.inventory[i][1];
                        array_push(_inventoryActions, _itemAction); 
                    }
                }

                var _actionList = array_union(_unit.actions, _inventoryActions); 

				for (var i = 0; i < array_length(_actionList); i++) {
				    var _action = _actionList[i];
				    var _available = IsActionAvailable(_unit, _action);

				    // Add item count to option name if necessary
				    var _nameAndCount = _action.name;
				    if (_action.subMenu == "Item") _nameAndCount += string(" x{0}", _action.count);

				    // Define defaults for item properties
				    var _mpCost = (_action.subMenu != "Item" && variable_instance_exists(_action, "mpCost")) ? _action.mpCost : "";
				    var _damageRange = "";
				    var _healRange = "";
				    var _mpRange = "";
				    var _description = (_action.subMenu == "Item") ? _action.description : "";
					var _info = "";
					
					switch (_action.name)
					{
					    case "Attack":
					        var _minDamage = ceil(_unit.strength - _unit.strength * 0.25);
					        var _maxDamage = ceil(_unit.strength + _unit.strength * 0.25);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
					        break;
    
					    case "Lunge":
					        var _minBase = 500;
					        var _maxBase = 800;
					        var _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        var _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals heavy damage";
					        break;

					    case "Dragon Fury":
					        _minBase = 900;
					        _maxBase = 1800;
					        _minDamage = _minBase + ceil(_unit.strength * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.strength * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;
						
						case "Jump":
					        _minBase = 50;
					        _maxBase = 750;
					        _minDamage = _minBase + ceil(_unit.strength * 0.4);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.4);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals heavy damage";
					        break;
							
						case "Twister Lunge":
							 _minBase = 500;
					        _maxBase = 800;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals wind damage";
					        break;
						case "Dark Arrow":
							 _minBase = 500;
					        _maxBase = 800;
					        _minDamage = _minBase + ceil(_unit.strength * 0.6);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.6);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals dark damage";
					        break;
							
						case "Ice Arrow":
							 _minBase = 550;
					        _maxBase = 900;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
					        break;
						
						case "Void Piercer":
							 _minBase = 500;
					        _maxBase = 800;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals dark damage";
					        break;
						
						case "Aim Shot":
							 _minBase = 200;
					        _maxBase = 650;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals heavy damage";
					        break;
						
						case "Cyclone Shot":
							 _minBase = 500;
					        _maxBase = 1050;
					        _minDamage = _minBase + ceil(_unit.strength * 0.9);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.9);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals wind damage";
					        break;
							
						case "Spectral Rain":
							 _minBase = 950;
					        _maxBase = 2150;
					        _minDamage = _minBase + ceil(_unit.strength * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.strength * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;

					    case "Flame Sword":
							_minBase = 50;
					        _maxBase = 300;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;
							
					    case "Ice Sword":
					        _minBase = 150;
					        _maxBase = 300;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
					        break;
						
						case "Stormstrike":
							 _minBase = 500;
					        _maxBase = 800;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals electric damage";
							break;
							
					    case "Excalibur":
					        _minBase = 700;
					        _maxBase = 1200;
					        _minDamage = _minBase + ceil(_unit.strength * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.strength * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;
							
						case "V Slash":
					        _minBase = 1000;
					        _maxBase = 2200;
					        _minDamage = _minBase + ceil(_unit.strength * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.strength * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;
						
						case "Vorpal Strike":
					        _minBase = 1500;
					        _maxBase = 2600;
					        _minDamage = _minBase + ceil(_unit.strength * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.strength * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;
						
						case "Nebula Strike":
					        _minBase = 600;
					        _maxBase = 1800;
					        _minDamage = _minBase + ceil(_unit.strength * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.strength * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals heavy damage";
					        break;

					    case "Fire":
					        _minBase = 300;
					        _maxBase = 450;
					        _minDamage = _minBase + ceil(_unit.magic * 0.4);
					        _maxDamage = _maxBase + ceil(_unit.magic * 0.4);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;

					    case "Fira":
					        _minBase = 500;
					        _maxBase = 600;
					        _minDamage = _minBase + ceil(_unit.magic * 0.6);
					        _maxDamage = _maxBase + ceil(_unit.magic * 0.6);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;
							
						 case "Fireball":
					        _minBase = 600;
					        _maxBase = 750;
					        _minDamage = _minBase + ceil(_unit.magic * 0.7);
					        _maxDamage = _maxBase + ceil(_unit.magic * 0.7);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;		

					    case "Firaga":
					        _minBase = 700;
					        _maxBase = 850;
					        _minDamage = _minBase + ceil(_unit.magic * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;
							
						 case "Fire Vortex":
					        _minBase = 1050;
					        _maxBase = 1420;
					        _minDamage = _minBase + ceil(_unit.magic * 0.8);
					        _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;

					    case "Blazing":
					        _minBase = 1000;
					        _maxBase = 1350;
					        _minDamage = _minBase + ceil(_unit.magic * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;
							
						case "Holy Strike":
					        _minBase = 600;
					        _maxBase = 1550;
					        _minDamage = _minBase + ceil(_unit.magic * 1.0);
					        _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
					        _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;

					    case "Ice":
						    _minBase = 300;
						    _maxBase = 450;
						    _minDamage = _minBase + ceil(_unit.magic * 0.4);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.4);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
						    break;

						case "Ice 2":
						    _minBase = 500;
						    _maxBase = 650;
						    _minDamage = _minBase + ceil(_unit.magic * 0.6);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.6);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
						    break;

						case "Ice 3":
						    _minBase = 720;
						    _maxBase = 950;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
						    break;


					    case "Meteor":
					        _minBase = 800;
						    _maxBase = 1350;
						    _minDamage = _minBase + ceil(_unit.magic * 1.0);
						    _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
						    break;
						
						 case "Earthquake":
					        _minBase = 620;
						    _maxBase = 950;
						    _minDamage = _minBase + ceil(_unit.magic * 1.0);
						    _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals heavy damage";
						    break;

					    case "Lightning":
					        _minBase = 420;
						    _maxBase = 850;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals electric damage";
					        break;

					    case "Tornado":
					        _minBase = 220;
						    _maxBase = 750;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals wind damage";
					        break;
							
					    case "Mystic Flare":
					        _minBase = 820;
						    _maxBase = 1850;
						    _minDamage = _minBase + ceil(_unit.magic * 1.0);
						    _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;

					    case "Shiva":
					       _minBase = 1020;
						    _maxBase = 1450;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals ice damage";
					        break;

					    case "Bahamut":
					       _minBase = 1520;
						    _maxBase = 3050;
						    _minDamage = _minBase + ceil(_unit.magic * 1.0);
						    _maxDamage = _maxBase + ceil(_unit.magic * 1.0);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals true damage";
					        break;

					    case "Leviathan":
					        _minBase = 1020;
						    _maxBase = 1550;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals water damage";
					        break;

					    case "Ifrit":
					        _minBase = 1020;
						    _maxBase = 1350;
						    _minDamage = _minBase + ceil(_unit.magic * 0.8);
						    _maxDamage = _maxBase + ceil(_unit.magic * 0.8);
						    _damageRange = string(_minDamage) + "-" + string(_maxDamage);
							_info = "\nDeals fire damage";
					        break;

					    
					    case "Heal":
					        _minBase = 100;
					        _maxBase = 1020;
					        var _minHeal = _minBase + ceil(_unit.magic * 0.4);
					        var _maxHeal = _maxBase + ceil(_unit.magic * 0.4);
					        _healRange = string(_minHeal) + "-" + string(_maxHeal);
							_info = "\nRestore HP";
					        break;

					    case "Heal 2":
					        _minBase = 310;
					        _maxBase = 1320;
					        _minHeal = _minBase + ceil(_unit.magic * 0.6);
					        _maxHeal = _maxBase + ceil(_unit.magic * 0.6);
					        _healRange = string(_minHeal) + "-" + string(_maxHeal);
							_info = "\nRestore HP";
					        break;

					    case "Cure":
					        _minBase = 100;
					        _maxBase = 1000;
					        _minHeal = _minBase + ceil(_unit.magic * 1.0);
					        _maxHeal = _maxBase + ceil(_unit.magic * 1.0);
					        _healRange = string(_minHeal) + "-" + string(_maxHeal);
							_info = "\nRestore HP";
					        break;
						
						case "Assess":
					        _info = "\nShows informations";
					        break;
						
					    case "Resurrect":
					        _info = "\nResurrect ally";
					        break;

					    case "Potion":
					        _description = "\nRestores 930 HP";
					        break;

					    case "Ether":
					        _description = "\nRestores 1500 MP";
					        break;

					    case "Elixir":
					       _description = "\nRestores 1500 HP\nand MP";
					        break;

					    case "Revive":
					        _description = "\nRevive an ally.";
					        break;
							
						case "Remedy":
					        _description = "\nRemove status\nailments.";
					        break;	

					    case "H-Potion":
					        _description = "\nFully restores HP";
					        break;

					    case "H-Elixir":
					        _description = "\nFully restores HP\nand MP";
					        break;

					    case "H-Ether":
					        _description = "\nFully restores MP";
					        break;
							
						 case "X-Ether":
					        _description = "\nFully restores MP\nto all members";
					        break;
							
						case "X-Potion":
					        _description = "\nFully restores HP\nto all members";
					        break;		

					    case "Wipe Out":
					        _description = "\nDeals 55000 damage";
					        break;
					}

                   // If this is an item, limit menu options to description only
				    var actionEntry = _action.subMenu == "Item"
				        ? [_nameAndCount, MenuSelectAction, [_unit, _action], _available, _description]
				        : [_nameAndCount, MenuSelectAction, [_unit, _action], _available, _mpCost, _damageRange, _healRange, _mpRange, _info];

				    // Add top-level action or create/add to a submenu
				    if (_action.subMenu == -1) {
				        array_push(_menuOptions, actionEntry);
				    } else {
				        if (is_undefined(_subMenus[$ _action.subMenu])) {
				            variable_struct_set(_subMenus, _action.subMenu, [actionEntry]);
				        } else {
				            array_push(_subMenus[$ _action.subMenu], actionEntry);
                        }
                    }
                }

                // Turn sub menus into an array
                var _subMenusArray = variable_struct_get_names(_subMenus);
                for (var i = 0; i < array_length(_subMenusArray); i++)
                {
                    // Sort submenu if needed
                    // (here)
                    
                    // Add back option at end of each submenu
                    array_push(_subMenus[$ _subMenusArray[i]], ["Back", MenuGoBack, -1, true]);
                    // Add submenu into main menu
                    array_push(_menuOptions, [_subMenusArray[i], SubMenu, [_subMenus[$ _subMenusArray[i]]], true]);
                }

                // Sort top level menu
                array_sort(_menuOptions, function(_a, _b)
                {
                    var _Priority = function(_option)
                    {
                        if (_option[0] == "Attack") return 99;
                        if (_option[0] == "Magic") return 50;
						if (_option[0] == "Skill") return 50;
						if (_option[0] == "Black Magic") return 60;
						if (_option[0] == "White Magic") return 30;
                        if (_option[0] == "Defend") return 30;
                        if (_option[0] == "Item") return -10;
                        if (_option[0] == "Escape") return -15;
                        return 0;
                    };
                    return _Priority(_b) - _Priority(_a);
                });
                
                Menu(x + 10, y + 110, _menuOptions, ,74,60);
            }
            else // Enemy
            {
                // Run AI script for that enemy
                var _enemyAction = _unit.AIscript();
                if (_enemyAction != -1) BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]); 
            }
        }
        else
        {
            battleState = BattleStateTurnProgression;
        }
    }
}


function BattleStatePerformAction()
{
    // Initialize paralyze properties if they don’t exist for currentUser
	if (currentUser != undefined && !variable_instance_exists(currentUser, "paralyzed")) {
	    currentUser.paralyzed = false;
	    currentUser.paralyzeTurns = 0;
	}
	
	if (currentUser.hp <= 0) {
    currentUser.paralyzed = false; // Remove paralysis upon death
    currentUser.paralyzeTurns = 0;
}

	// If the character is silenced, show a message and skip their turn
	if (currentUser != undefined && currentUser.paralyzed)
	{
	    // Update battle text to indicate the player is silenced
	    battleText = string(currentUser.name) + " is paralyzed and cannot act!";

	    // Set the character to the multi-frame idle2 sprite for silenced state
	    currentUser.sprite_index = currentUser.sprites.idle2;
    
	    // Reset image_index to 0 to start the animation from the beginning each turn
	    if (currentUser.image_index == 0) {
	        currentUser.image_index = 0;
	    }

	    // Prevent action execution by clearing currentAction immediately
	    currentAction = undefined;

	    // Only proceed to the next battle state when idle2 animation is complete
	    if (currentUser.image_index >= currentUser.image_number - 1)
	    {
	        // Decrement silence turns only after the idle2 animation completes
	        currentUser.paralyzeTurns--;

	        // If silence duration is over, remove the silence effect
	        if (currentUser.paralyzeTurns <= 0)
	        {
	            currentUser.paralyzed = false;
	            currentUser.paralyzeTurns = 0;
	        }

	        // Move to the next turn
	        battleState = BattleStateVictoryCheck;
	    }

	    return;
	}

    // If the action is still playing (animation not done)
    if (currentUser != undefined && currentUser.acting)
    {
        // Check if animation has finished
        if (currentUser.image_index >= currentUser.image_number - 1)
        {
            // Ensure currentAction and currentUser are defined before accessing `name`
            if (currentAction != undefined && currentAction.name == "Jump" && currentUser.name == "Hannah")
            {
                currentUser.acting = false;
            }
            else if (currentAction != undefined && currentAction.name == "Hellfire" && currentUser.name == "Sephiroth")
            {
                currentUser.acting = false;
            }
			else if (currentAction != undefined && currentAction.name == "SephSlash" && currentUser.name == "Sephiroth")
            {
                currentUser.acting = false;
            }
			 else if (currentAction != undefined && currentAction.name == "Nebula Strike" && currentUser.name == "Milan")
            {
                currentUser.acting = false;
            }
            else
            {
                // For other actions, return to idle after the action ends
                with (currentUser)
                {
                    sprite_index = sprites.idle;
                    image_index = 0;
                    acting = false;
                }
            }

            // Handle effect sprite if applicable
            if (currentAction != undefined && variable_struct_exists(currentAction, "effectSprite"))
            {
                if (variable_struct_exists(currentAction, "showSingleEffectSprite") && currentAction.showSingleEffectSprite)
                {
                    // Calculate central position (if there are multiple targets)
                    var centralX = 0;
                    var centralY = 0;
                    for (var i = 0; i < array_length(currentTargets); i++)
                    {
                        centralX += currentTargets[i].x;
                        centralY += currentTargets[i].y;
                    }
                    centralX /= array_length(currentTargets);
                    centralY /= array_length(currentTargets);
                    instance_create_depth(centralX, centralY, currentTargets[0].depth - 1, oBattleEffect, {sprite_index: currentAction.effectSprite});
                }
                else
                {
                    // Create effect sprites for each individual target
                    for (var i = 0; i < array_length(currentTargets); i++)
                    {
                        instance_create_depth(currentTargets[i].x, currentTargets[i].y, currentTargets[i].depth - 1, oBattleEffect, {sprite_index: currentAction.effectSprite});
                    }
                }

                // Play the corresponding effect sound (if it exists)
                if (variable_struct_exists(currentAction, "effectSound"))
                {
                    audio_play_sound(currentAction.effectSound, 1, false);
                }
            }

            damageTextDisplayed = false;
        }
    }
    else // Wait for delay and then end the turn
    {
        if (!instance_exists(oBattleEffect))
        {
            if (!damageTextDisplayed)
            {
                // Display damage text only if `currentAction` and `func` are defined
                if (currentAction != undefined && is_undefined(currentAction.func) == false) {
                    currentAction.func(currentUser, currentTargets);
                }

                // Mark damage text as displayed
                damageTextDisplayed = true;
            }

            battleWaitTimeRemaining--;
            if (battleWaitTimeRemaining == 0)
            {
                battleState = BattleStateVictoryCheck;
            }
        }
    }
}


function BattleStateVictoryCheck()
{
    if (is_undefined(global.deathDialogueQueue)) {
        global.deathDialogueQueue = [];
    }

    // Prioritize death dialogues
    if (array_length(global.deathDialogueQueue) > 0) {
        battleState = BattleStateDeathDialogue; // Switch to death dialogue state
        return;
    }

    // Check if all enemies or all party members are dead
    var _endTheBattle = false;
    var _noEnemiesAlive = !array_any(enemyUnits, function(_unit) { return (_unit.hp > 0); });
    var _noPartyAlive = !array_any(partyUnits, function(_unit) { return (_unit.hp > 0); });

    // Check if the player lost
    if (_noPartyAlive) {
        audio_stop_all();
        audio_play_sound(snd_GameOver, 0, true);
        _endTheBattle = true;
        conclusionType = 0;
        battleEndMessages[0] = "All party members defeated!";
        battleEndMessages[1] = "Game over...";

        switch (enemyUnits[0].name) {
            case "Sephiroth":
                battleEndMessages[2] = "Milan: Noo.. Everyone!";
                battleEndMessages[3] = "Sephiroth: You are still weak to defeat me.";
                break;
            case "Bahamut":
                battleEndMessages[2] = "Kenneth: So that was not enough?";
                battleEndMessages[3] = "Hannah: We need to get stronger.";
                battleEndMessages[4] = "Bahamut: You are not worthy to challenge me!";
                break;
            case "Leviathan":
                battleEndMessages[2] = "Leviathan: Train harder to defeat me mortals.";
                break;
        }
    } else {
        // Handle death dialogues before removing an enemy
        for (var i = 0; i < array_length(enemyUnits); i++) {
            var _enemy = enemyUnits[i];

            if (!variable_instance_exists(_enemy, "deathDialogueShown")) {
                _enemy.deathDialogueShown = false;
            }

            if (_enemy.hp <= 0 && !_enemy.deathDialogueShown &&
                !is_undefined(_enemy.deathDialogue) &&
                array_length(_enemy.deathDialogue) > 0) 
            {
                if (!variable_instance_exists(_enemy, "dialogueIndex")) {
                    _enemy.dialogueIndex = 0;
                }

                if (!array_contains(global.deathDialogueQueue, _enemy)) {
                    array_push(global.deathDialogueQueue, _enemy);
                }

                _enemy.deathDialogueShown = true;
            }
        }

        if (array_length(global.deathDialogueQueue) > 0) {
            battleState = BattleStateDeathDialogue;
            return;
        }

    // Handle the Warring Triad mechanic
    for (var i = 0; i < array_length(enemyUnits); i++) {
        var _enemy = enemyUnits[i];

        if (_enemy.hp <= 0) {
            // Check if there is a next enemy in the hierarchy
            if (!is_undefined(_enemy.nextEnemy) && _enemy.nextEnemy != noone) {
                // Access the next enemy using the string key
                var _newEnemy = global.enemies[$ _enemy.nextEnemy];

                // Set up transition data
                transitionActive = true;
                transitionTimer = 0;
                transitionEnemy = _enemy;
                transitionNewEnemy = instance_create_depth(_enemy.x, _enemy.y - 150, _enemy.depth, oBattleUnitEnemy, _newEnemy); // Initialize new enemy above the battlefield
                transitionStartY = _enemy.y;

                // Switch to the transition state
                battleState = BattleStateTransition;
                return; // Stop processing further so the transition can happen
            }
        }
    }

        // If no more enemies exist after replacements, then the player wins
        _noEnemiesAlive = !array_any(enemyUnits, function(_unit) { return (_unit.hp > 0); });

        if (_noEnemiesAlive) {
            audio_stop_all();
            audio_play_sound(snd_Win, 1, true);
            conclusionType = 1;
            global.levelUpSummaryStep = 0;
            levelDisplay = true;
            _endTheBattle = true;
            battleEndMessages[0] = "Victory!!";
			
		//	for (var i = 0; i < array_length(partyUnits); i++) {
          //      var _party = partyUnits[i];
                // Check if has a victory sprite defined
         //       if (variable_struct_exists(_party.sprites, "victory")) {
         //           _party.sprite_index = _party.sprites.victory;
       //         }
       //     }

            // Calculate XP and money rewards
            var totalXpGained = 0;
            global.totalMoneyGained = 0;

            for (var i = 0; i < array_length(enemyUnits); i++) {
                totalXpGained += enemyUnits[i].xpValue;
                global.totalMoneyGained += enemyUnits[i].moneyDrop;
            }

            battleXpGained = totalXpGained;
            global.totalMoney += global.totalMoneyGained;

            levelUpMessages = [];
            global.levelUpSummary = [];
            award_party_xp(totalXpGained);
     

            // Append XP gained message
            //battleEndMessages[1] = string("Gained {0} experience points", totalXpGained);
            
            // Append money gained message
            //battleEndMessages[array_length(battleEndMessages)] = string("Obtained {0} Money", totalMoneyGained);

            // Append level up messages
            //for (var i = 0; i < array_length(levelUpMessages); i++) {
            //    battleEndMessages[array_length(battleEndMessages)] = levelUpMessages[i];
            //}

            // Handle item drops
            global.droppedItems = [];
            for (var i = 0; i < array_length(enemyUnits); i++) {
                var enemyDrops = DropItem(enemyUnits[i]);
                show_debug_message("Enemy Drops: " + string(enemyDrops)); // Debug message
                for (var j = 0; j < array_length(enemyDrops); j++) {
                    var itemName = enemyDrops[j].name;
                    var amount = enemyDrops[j].amount;
                    show_debug_message("Processing item: " + itemName + ", Amount: " + string(amount)); // Debug message
                    // Check if item already dropped
                    var existingItemIndex = -1;
                    for (var k = 0; k < array_length(global.droppedItems); k++) {
                        if (global.droppedItems[k].name == itemName) {
                            existingItemIndex = k;
                            break;
                        }
                    }
                    if (existingItemIndex == -1) {
                        array_push(global.droppedItems, { name: itemName, amount: amount });
                    } else {
                        global.droppedItems[existingItemIndex].amount += amount;
                    }
                }
            }

            // Append item drop messages
            //for (var i = 0; i < array_length(global.droppedItems); i++) {
            //    var itemName = global.droppedItems[i].name;
            //    var amount = global.droppedItems[i].amount;
            //    battleEndMessages[array_length(battleEndMessages)] = string("Obtained {0} x{1}", itemName, amount);
            //}
        }
    }
    // Determine the next map sound if needed
    switch (global.nextMap)
    {
        case "Room1":
            global.nextMapSound = snd_Overworld;
            break;
        case "Room3":
            global.nextMapSound = snd_Forest;
            break;        
        case "Room4":
            global.nextMapSound = snd_Desert;
            break;    
        case "Room5":
            global.nextMapSound = snd_GigaLair;
            break;
        case "Room7":
            global.nextMapSound = snd_BossFinal;
            break;
		case "ExtraBoss":
			global.nextMapSound = snd_SephMap;
			break;
        case "Leviathan_Map":
			global.nextMapSound = snd_Leviathan;
			break;
		case "Tower":
			global.nextMapSound = snd_Tower;
			break;
		case "Pyramid":
			global.nextMapSound = snd_Opening;
			break;
        default:
    }

    // Escaped
    if (escaped)
    {
        conclusionType = 2;
        _endTheBattle = true;
        battleEndMessages[0] = "Escaped!"
        battleEndMessages[1] = "No experience gained."
    }
	
    battleState = _endTheBattle ? BattleStateEnding : BattleStateTurnProgression;
}

function BattleStateTransition() {
    if (!transitionActive) return;

    // Update the transition timer
    transitionTimer++;

    // Define transition duration for each phase
    var moveDownDuration = 600;
    var totalDuration = 630; // Total time for the transition

    // Part 1: Move enemy downward and new enemy downward from above
    if (transitionTimer <= moveDownDuration) {
        // Move enemy downward
        transitionEnemy.y = lerp(transitionStartY, transitionStartY + 150, transitionTimer / moveDownDuration);
        transitionEnemy.image_xscale = -1; // Make enemy face left

        // Move enemy downward from above
        var enemyStartY = transitionStartY - 150; // Start above the battlefield
        transitionNewEnemy.y = lerp(enemyStartY, transitionStartY, transitionTimer / moveDownDuration);
		
		// Play the next enemy's music at the start of the transition
        if (transitionTimer == 1) {
            audio_stop_all(); // Stop the current music
            audio_play_sound(transitionNewEnemy.music, 1, true); // Play the new enemy's music
        }
    }
	   // Part 2: Finalize transition (New enemy fully replaces recent enemy)
	else if (transitionTimer <= totalDuration) {
	    // Swap recent enemy with new enemy
	    transitionEnemy.name = transitionNewEnemy.name;
	    transitionEnemy.hp = transitionNewEnemy.hp;
	    transitionEnemy.hpMax = transitionNewEnemy.hpMax;
	    transitionEnemy.sprites = transitionNewEnemy.sprites;
	    transitionEnemy.sprite_index = transitionNewEnemy.sprites.idle; // Set the sprite index to Gilgamesh's idle sprite
	    transitionEnemy.actions = transitionNewEnemy.actions;
	    transitionEnemy.weaknesses = transitionNewEnemy.weaknesses;
	    transitionEnemy.resistances = transitionNewEnemy.resistances;
	    transitionEnemy.absorbs = transitionNewEnemy.absorbs;
	    transitionEnemy.nextEnemy = transitionNewEnemy.nextEnemy;
		transitionEnemy.AIscript = transitionNewEnemy.AIscript;
		transitionEnemy.preBattleDialogue = transitionNewEnemy.preBattleDialogue;

		
	    // Ensure enemy is fully in position
	    transitionEnemy.y = transitionStartY;
	    transitionEnemy.image_xscale = -1; // Face left
	    transitionEnemy.image_alpha = 1; 
		transitionEnemy.image_blend = c_white;
		
	}
    // Transition complete
else {
    // Replace recent enemy with new enemy in the enemyUnits array
    for (var i = 0; i < array_length(enemyUnits); i++) {
        if (enemyUnits[i].id == transitionEnemy.id) {
            enemyUnits[i] = transitionEnemy; // Replace recent enemy with new enemy
            break;
        }
    }

    // Debug: Verify enemyUnits array
    for (var i = 0; i < array_length(enemyUnits); i++) {
        show_debug_message("Enemy " + string(i) + ": " + enemyUnits[i].name);
    }

    // Reset transition state
    transitionActive = false;
    transitionTimer = 0;
    transitionEnemy = noone;
    transitionNewEnemy = noone;

     // Check for pre-battle dialogue
        if (!is_undefined(enemyUnits[0].preBattleDialogue) && array_length(enemyUnits[0].preBattleDialogue) > 0) {
            currentEnemy = enemyUnits[0]; // Assuming the first enemy for dialogue

            // Initialize dialogue tracking variables
            currentEnemy.preDialogueIndex = 0; // For pre-battle dialogue
            currentEnemy.dialogueIndex = 0; // For death dialogue
            currentEnemy.midDialogueIndex = 0; // For mid-battle dialogue

            currentEnemy.midBattleDialogueShown = false;
            currentEnemy.deathDialogueShown = false;

            battleState = BattleStatePreBattleDialogue;
        } else {
            // Resume battle
            battleState = BattleStateTurnProgression;
        }
        return;
    }
}

function BattleStateTurnProgression() {
	 if (transitionActive) return; // Pause turn progression during transitiom
	if (global.assessViewing) return; // Pause turn progression
	
    // If Cerberus had an extra turn, reset it now
    if (global.extraTurnActive) {
        global.extraTurnActive = false; 
        global.enemyExtraTurnUsed = 1; // Mark that he has used his extra attack
    } else {
        turnCount++; // Total turns
        turn++;

        // Loop turns
        if (turn > array_length(unitTurnOrder) - 1) {
            turn = 0;
            roundCount++;
        }

        // Reset extra turn tracker when it's a new turn
        global.enemyExtraTurnUsed = 0; 
    }

    var _unit = unitTurnOrder[turn];

    // Check if the current units
    if (instance_exists(_unit) && _unit.enemy == true && (_unit.name == "Cerberus" || _unit.name == "Gigatoa"
		|| _unit.name == "Deity III" || _unit.name == "Deity II" || _unit.name == "Deity I" || _unit.name == "Exarch")) {
			
        var extraTurnChance = 50; // 50% chance to attack again
        var roll = irandom(99); // Generate a random number between 0 and 99

        show_debug_message(string (_unit.name) + " roll: " + string(roll) + " / Needed: <" + string(extraTurnChance));
        show_debug_message("Extra Turn Used: " + string(global.enemyExtraTurnUsed));

        // Only allow one extra attack per turn
        if (roll < extraTurnChance && global.enemyExtraTurnUsed == 0) { 
            show_debug_message(string (_unit.name) + " gets an extra turn!");

            // Activate extra turn flag
            global.extraTurnActive = true;

            // Run AI script for Cerberus again before progressing the turn
            var _enemyAction = _unit.AIscript();
            if (_enemyAction != -1) {
                BeginAction(_unit.id, _enemyAction[0], _enemyAction[1]); 
                return; // Stops turn progression so Cerberus can act again
            }
        } else {
            show_debug_message(string (_unit.name) + " does NOT get an extra turn.");
        }
    }

    // Prioritize death dialogues if they exist
    if (array_length(global.deathDialogueQueue) > 0) {
        battleState = BattleStateDeathDialogue; // Switch to death dialogue state
        return;
    }

    // Check for mid-battle dialogue
    var _unit = unitTurnOrder[turn];
    if (
        instance_exists(_unit) &&
        _unit.enemy &&
        (!variable_instance_exists(_unit, "midBattleDialogueShown") || !_unit.midBattleDialogueShown) &&
        _unit.hp <= (_unit.hpMax * 0.5) &&
        !is_undefined(_unit.midBattleDialogue) &&
        array_length(_unit.midBattleDialogue) > 0
    ) {
        // Initialize `midBattleDialogueShown` if it doesn't exist
        if (!variable_instance_exists(_unit, "midBattleDialogueShown")) {
            _unit.midBattleDialogueShown = false;
        }

        // Initialize `midDialogueIndex` if it doesn't exist
        if (!variable_instance_exists(_unit, "midDialogueIndex")) {
            _unit.midDialogueIndex = 0;
        }

        battleText = _unit.midBattleDialogue[_unit.midDialogueIndex]; // Display the first dialogue
        battleState = BattleStateMidBattleDialogue;
        _unit.midBattleDialogueShown = true; // Mark as shown
        return;
    }

    // If no special dialogues, proceed to select action
    battleText = "";
    battleState = BattleStateSelectAction;
}

function BattleStateEnding() {
    if (keyboard_check_pressed(vk_enter)) {
        audio_play_sound(snd_Menu, 1, false);

        if (levelDisplay) {
            // Cycle through level-up messages
            global.levelUpSummaryStep++;

            // If all level-up messages are shown, disable level-up display
            if (global.levelUpSummaryStep > array_length(global.levelUpSummary)) {
                levelDisplay = false; // Hide level-up screen
                global.lastLearnedSkills = []; // Clear learned skills
                global.showItemDrops = true; // Reset for next time
                global.levelUpSummaryStep = 0; // Reset step counter
            }
        } else {
            // Move to the next battle-end message
            battleEndMessageProg++;
        }
    }
	

    // ✅ FIXED: Correct array_length usage
    if (battleEndMessageProg >= array_length(battleEndMessages)) 
    {
        transitionProg -= 0.01;
        if (transitionProg <= 0.0)
        {
            // Stop all current sounds
            audio_stop_sound(snd_Win);
            audio_stop_sound(snd_GameOver);
            audio_stop_sound(snd_Overworld);
            audio_stop_sound(snd_Ending);

            // Restore camera size
            var camera = view_camera[0];
            camera_set_view_size(camera, global.original_cam_width, global.original_cam_height);

            // Handle game over vs. next scene
            if (conclusionType == 0)
            {
				scr_reset_globals();
                game_restart(); // Restart game if game over
            }
            else
            {
                // Play next map sound
                audio_play_sound(global.nextMapSound, 1, true);
                
                // Stop battle music
                audio_stop_sound(snd_BattleScene);
                audio_stop_sound(snd_ExtraBossTheme);
				audio_stop_sound(snd_ExtraBossTheme2);
                audio_stop_sound(snd_Boss);
                audio_stop_sound(snd_FinBossPhase2);
                audio_stop_sound(snd_FinBossPhase1);
                audio_stop_sound(snd_WarringTriad);
                audio_stop_sound(snd_PyramidBoss);
                audio_stop_sound(snd_SephirothBattle2);
                audio_stop_sound(snd_SephirothBattle1);
                audio_stop_sound(snd_IronGiant);
                audio_stop_sound(snd_Cerberus);
                audio_stop_sound(snd_FourFiends);
				

                instance_destroy(); // End the battle instance
            }
        }
    }
    else
    {
        // Display the current victory message
        battleText = battleEndMessages[battleEndMessageProg];
    }
}

function BattleStatePreBattleDialogue() {
    if (!variable_instance_exists(currentEnemy, "preDialogueIndex")) {
        currentEnemy.preDialogueIndex = 0; // Initialize preDialogueIndex if it doesn't exist
    }

    if (currentEnemy.preDialogueIndex < array_length(currentEnemy.preBattleDialogue)) {
        // Display the current dialogue
        battleText = currentEnemy.preBattleDialogue[currentEnemy.preDialogueIndex];

        // Progress on keypress
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);
            currentEnemy.preDialogueIndex++;
        }
    } else {
        // Dialogue finished, move to battle
        battleText = "";
        battleState = BattleStateSelectAction;
    }
}

function BattleStateMidBattleDialogue() {
    // Prioritize death dialogues
    if (array_length(global.deathDialogueQueue) > 0) {
        battleState = BattleStateDeathDialogue; // Switch to death dialogue state
        return;
    }

    var _unit = unitTurnOrder[turn];
    if (
        !is_undefined(_unit.midBattleDialogue) &&
        _unit.midDialogueIndex < array_length(_unit.midBattleDialogue)
    ) {
        battleText = _unit.midBattleDialogue[_unit.midDialogueIndex];
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);
            _unit.midDialogueIndex++; // Use `midDialogueIndex` here
        }
    } else {
        battleText = "";
        battleState = BattleStateSelectAction; // Resume the battle
    }
}

function BattleStateDeathDialogue() {
    // The queue should always exist because we initialized it globally
    if (is_undefined(global.deathDialogueQueue)) {
        global.deathDialogueQueue = [];
    }

    // If the queue is empty, return to victory check
    if (array_length(global.deathDialogueQueue) == 0) {
        battleState = BattleStateVictoryCheck;
        return;
    }

    // Get the first enemy in the queue
    var _enemy = global.deathDialogueQueue[0];

    // Ensure `dialogueIndex` is initialized
    if (!variable_instance_exists(_enemy, "dialogueIndex")) {
        _enemy.dialogueIndex = 0;
    }

    // Display its death dialogue
    if (!is_undefined(_enemy.deathDialogue) && _enemy.dialogueIndex < array_length(_enemy.deathDialogue)) {
        battleText = _enemy.deathDialogue[_enemy.dialogueIndex];
        if (keyboard_check_pressed(vk_enter)) {
            audio_play_sound(snd_Menu, 1, false);
            _enemy.dialogueIndex++; // Use `dialogueIndex` here
        }
    } else {
        // Remove the enemy from the queue once its dialogue is finished
        array_delete(global.deathDialogueQueue, 0, 1); // Remove the first element

        // Clear dialogue text and check for the next enemy in the queue
        battleText = "";

        if (array_length(global.deathDialogueQueue) > 0) {
            // Keep the state in Death Dialogue if more remain
            battleState = BattleStateDeathDialogue;
        } else {
            // Return to Victory Check if no more dialogues remain
            battleState = BattleStateVictoryCheck;
        }
    }
}

function BattleStateBegin() {
    transitionProg += 0.01;
    if (transitionProg >= 1.0) {
        transitionProg = 1.0;

        // Check for pre-battle dialogue
        if (!is_undefined(enemyUnits[0].preBattleDialogue) && array_length(enemyUnits[0].preBattleDialogue) > 0) {
            currentEnemy = enemyUnits[0]; // Assuming the first enemy for dialogue

            // Initialize dialogue tracking variables
            currentEnemy.preDialogueIndex = 0; // For pre-battle dialogue
            currentEnemy.dialogueIndex = 0; // For death dialogue
            currentEnemy.midDialogueIndex = 0; // For mid-battle dialogue

            currentEnemy.midBattleDialogueShown = false;
            currentEnemy.deathDialogueShown = false;

            battleState = BattleStatePreBattleDialogue;
        } else {
            battleState = BattleStateSelectAction; // Skip dialogue if none exists
        }
    }
}

battleState = BattleStateBegin;