if (active)
{
    //Control menu with keyboard
    var previousHover = hover;

    hover += (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) - (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up));

    if (hover > array_length(options) - 1) hover = 0;
    if (hover < 0) hover = array_length(options) - 1;

    // Play cursor sound if hover changes
    if (hover != previousHover) {
        audio_play_sound(snd_Menu, 1, false);
    }

    //Execute selected option
    if (keyboard_check_pressed(vk_enter)) 
    {
        if ((array_length(options[hover]) > 1) && (options[hover][3] == true))
        {
            if (options[hover][1] != -1)
            {
                var _func = options[hover][1];
                if (options[hover][2] != -1) script_execute_ext(_func, options[hover][2]); else _func();
				audio_play_sound(snd_Menu, 1, false);
            }
        }
    }

    if (keyboard_check_pressed(vk_escape))
    {
        if (subMenuLevel > 0) MenuGoBack();
		audio_play_sound(snd_Menu,1,false);
    }
}


