function show_ui_message(message, duration) {
    global.ui_message = message;
    global.ui_state = 1;
    global.ui_timer = duration * room_speed; // Convert duration to steps
}
