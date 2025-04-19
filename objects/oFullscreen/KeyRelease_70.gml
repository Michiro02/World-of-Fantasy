if (window_get_fullscreen()) {
    window_set_fullscreen(false);
} else {
    var _width = display_get_width();
    var _height = display_get_height();

    // Target game size (same as your room size)
    var game_w = 640;
    var game_h = 500;

    // Calculate the scale to keep the aspect ratio
    var scale = min(_width / game_w, _height / game_h);

    var scaled_w = game_w * scale;
    var scaled_h = game_h * scale;

    // Set the application surface to your game size
    surface_resize(application_surface, game_w, game_h);

    // Center the scaled image
    var offset_x = (_width - scaled_w) * 0.5;
    var offset_y = (_height - scaled_h) * 0.5;

    // Turn on fullscreen
    window_set_fullscreen(true);

    // Set GUI to scale
    display_set_gui_maximize();
    display_set_gui_size(game_w, game_h);

}
