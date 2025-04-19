function NewEncounter(_enemies, _bg)
{
    
    var camera = view_camera[0];
    
    // Store original camera size in global variables
    global.original_cam_width = camera_get_view_width(camera);
    global.original_cam_height = camera_get_view_height(camera);
    
    
    camera_set_view_size(camera, 320, 245);
    
    // Create the battle instance with the new camera position
    var cam_x = camera_get_view_x(camera);
    var cam_y = camera_get_view_y(camera);
    instance_create_depth(cam_x, cam_y, -9999, oBattle, { enemies: _enemies, creator: id, battleBackground: _bg });
}



function BattleChangeHP(_target, _amount, _livingCheck = 0, _element = "")
{
    //_livingCheck: 0 = alive only, 1 = dead only, 2 = any
    var _failed = false;
    if (_livingCheck == 0 && _target.hp <= 0) _failed = true;
    if (_livingCheck == 1 && _target.hp > 0) _failed = true;
    
    var _col = c_white;
    var _message = "";  // To store the message like "Weak!", "Resist", etc.
    
    // Check if the element matches target's weaknesses, resistances, or absorptions
    if (!_failed && _element != "")
    {
        // If target is weak to this element
        if (array_contains(_target.weaknesses, _element))
        {
            _message = "Weak!";
            _col = c_white;  
        }
        // If target is resistant to this element
        else if (array_contains(_target.resistances, _element))
        {
            _message = "Resist";
            _col = c_white;  
        }
        // If target absorbs this element (heals instead of damage)
        else if (array_contains(_target.absorbs, _element))
        {
            _message = "Absorbed!";
            _col = c_lime;  
        }
    }
    
    // Check for healing (positive amount)
    if (_amount > 0 && _message == "") _col = c_lime;  // Green for healing

    if (_failed) 
    {
        _col = c_white;
        _amount = "Failed";
    }
    
    // Create floating text for the message (if any)
    if (_message != "")
    {
        instance_create_depth(_target.x, _target.y - 15, _target.depth - 1, oFloatingText, {font: fnM5x7, col: _col, text: _message});
    }
    
    // Create floating text for the amount (damage or healing)
    instance_create_depth(_target.x, _target.y, _target.depth - 1, oFloatingText, {font: fnM5x7, col: _col, text: string(_amount)});
    
    // Apply the HP change, but only if the action didn't fail
    if (!_failed) _target.hp = clamp(_target.hp + _amount, 0, _target.hpMax);
}


function BattleChangeMP(_target, _amount, _show = false)
{
	if (_show) instance_create_depth(_target.x,_target.y,_target.depth-1, oFloatingText, {font: fnM5x7, col: c_aqua, text: string(_amount) + "mp"})
	_target.mp = clamp(_target.mp + _amount, 0, _target.mpMax);
}
//After picking an action, confirm any targets or options and then continue
function MenuSelectAction(_user, _action)
{
	//make menu inactive
	with (oMenu) active = false;
	
	with (oBattle)
	{
		if (_action.targetRequired)
		{
			with (targetCursor)
			{
				cursorAction = _action;
				cursorAll = _action.targetAll;
				if (cursorAll == MODE.VARIES) cursorAll = 0; //"toggle" starts as all by default
				cursorUser = _user;
				cursorActive = true;
				if (_action.targetEnemyByDefault) //cursorTarget enemy by default
				{
					cursorIndex = 0;
					cursorSide = oBattle.enemyUnits;
					cursorTarget = oBattle.enemyUnits[cursorIndex];
				}
				else //cursorTarget self by default
				{
					cursorSide = oBattle.partyUnits;
					cursorTarget = cursorUser;
					var _findSelf = function(_element, _user)
					{
						return (_element == cursorTarget)	
					}
					cursorIndex = array_find_index(oBattle.partyUnits, _findSelf);
				}
			}
		}
		else
		{
			with (oMenu) instance_destroy();
			BeginAction(_user,_action,-1)
		}
	}
}

function IsActionAvailable(_unit, _action)
{
	
	if (variable_struct_exists(_action, "mpCost"))
	{
		if (_unit.mp >= _action.mpCost) return true;	
	}
	else
	{
		return true;
	}
	return false;
}
