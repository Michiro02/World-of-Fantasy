// Handle fade effect (example for menu fade-in/out)
alpha += fade_speed;

if (alpha >= 1) {
    room_goto(Sequence);
	instance_destroy();
}
