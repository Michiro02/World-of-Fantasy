battleState();

//Cursor control
if (targetCursor.cursorActive)
{
    with (targetCursor)
    {
        
        //input
        var _keyUp = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up);
        var _keyDown = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down);
        var _keyLeft = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left);
        var _keyRight = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right);
        var _keyToggle = false;
        var _keyConfirm = false;
        var _keyCancel = false;
        cursorConfirmDelay++;
        if (cursorConfirmDelay > 1) 
        {
            _keyConfirm = keyboard_check_pressed(vk_enter);
            _keyCancel = keyboard_check_pressed(vk_escape);
            _keyToggle = keyboard_check_pressed(vk_shift);
        }
        var _moveH = _keyRight - _keyLeft;
        var _moveV = _keyDown - _keyUp;
    
        if (_moveH == -1) 
        {
            cursorSide = oBattle.partyUnits;
            audio_play_sound(snd_Menu, 1, false); // Sound for choosing players
        }
        if (_moveH == 1) 
        {
            cursorSide = oBattle.enemyUnits;
            audio_play_sound(snd_Menu, 1, false); // Sound for choosing enemies
        }
        
        
        //verify target list 
        if (cursorSide == oBattle.enemyUnits)
        {
            cursorSide = array_filter(cursorSide, function(_element, _index)
            {
                return _element.hp > 0;
            });
        }
        
        if (cursorAll == 0) //Single target mode
        {
            var previousIndex = cursorIndex;
            
            if (_moveV == 1) cursorIndex++;
            if (_moveV == -1) cursorIndex--;
            var _targets = array_length(cursorSide);
            if (cursorIndex < 0) cursorIndex = _targets - 1;
            if (cursorIndex > (_targets - 1)) cursorIndex = 0;
            
            if (cursorIndex != previousIndex) {
                audio_play_sound(snd_Menu, 1, false); // Sound for moving cursor within list
            }
            
            cursorTarget = cursorSide[cursorIndex];
            
            if (cursorAction.targetAll == MODE.VARIES && _keyToggle) //switch to all mode
			
            {
                cursorAll = 1; 
				 audio_play_sound(snd_Menu, 1, false);
            }
        }
        else //target all mode
        {
            cursorTarget = cursorSide;
            cursorError = false;
            if (cursorAction.targetAll == MODE.VARIES && _keyToggle) //switch to single mode
            {
                cursorAll = 0; 
				 audio_play_sound(snd_Menu, 1, false);
            }
        }
        
        if (!cursorError)
        {
            if (_keyConfirm)
            {
                with (oBattle) BeginAction(targetCursor.cursorUser, targetCursor.cursorAction, targetCursor.cursorTarget);
                with (oMenu) instance_destroy();
                cursorActive = false;    
                cursorConfirmDelay = 0;
            }
        }
        
        if (_keyCancel && !_keyConfirm)
        {
            with (oMenu) active = true;    
            cursorActive = false;
            cursorConfirmDelay = 0;
        }
    }
}
