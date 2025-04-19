// Step Event of oPlayer

if (room != previous_room) {
    encounter_timer = 0; // Reset counter when changing rooms
    encounter_threshold = irandom_range(120, 180); // New random threshold
    previous_room = room; // Update tracking
}

// --- ENCOUNTER LOGIC ---
if (encounter_timer >= encounter_threshold) {
    encounter_timer = 0;
    encounter_threshold = irandom_range(180, 300);

    var room_name = string(room_get_name(room));
    var data = variable_struct_get(global.encounter_data, room_name);

    if (data != undefined) {
        var enemyGroup = choose(data.enemies[0], data.enemies[1], data.enemies[2], data.enemies[3], data.enemies[4], data.enemies[5]);
        var bg = data.background;

        var music_to_play = snd_BattleScene;
        for (var i = 0; i < array_length(enemyGroup); i++) {
            if (enemyGroup[i].sound != undefined) {
                music_to_play = enemyGroup[i].sound;
                break;
            }
        }

        NewEncounter(enemyGroup, bg);
        audio_stop_all();
        audio_play_sound(music_to_play, 1, true);
    }
}

if (!global.game_paused && !global.dialogue_active && canMove) {
    var _inputH = (keyboard_check(ord("D")) || keyboard_check(vk_right)) - (keyboard_check(ord("A")) || keyboard_check(vk_left));
    var _inputV = (keyboard_check(ord("S")) || keyboard_check(vk_down)) - (keyboard_check(ord("W")) || keyboard_check(vk_up));

    var _inputM = sqrt(sqr(_inputH) + sqr(_inputV));  // Calculate the magnitude of the input vector

    if (_inputM != 0) {
		encounter_timer += 1;
        var _inputD = point_direction(0, 0, _inputH, _inputV);  // Calculate the direction only if there is input
        _inputH /= _inputM;  // Normalize the input vector
        _inputV /= _inputM;

        direction = _inputD;
        image_speed = 1;
    } else {
        image_speed = 0;
        animIndex = 0;
    }

    FourDirectionAnimate();

    // Apply the movement
    x += spdWalk * _inputH;
    y += spdWalk * _inputV;
    
    // Clamp the position within the room bounds
    x = clamp(x, 0, room_width);
    y = clamp(y, 0, room_height);
} else {
    // Ensure the player's movement is fully stopped during the dialogue
    image_speed = 0;
    animIndex = 0;
}


