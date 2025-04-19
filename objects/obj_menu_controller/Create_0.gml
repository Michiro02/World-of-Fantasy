// Create Event
selected_option = 0; // Start with the first option
settings_active = false; // Track whether the settings menu is active
global.menu_state = "main"; // Default to the main menu
global.selected_slot = 1; // Track the selected save slot for Load Game
global.load_game_flag = false; // Initialize the flag

// Intro sequence variables
is_intro = true; // Start with the intro sequence
intro_step = 0; 
fade_alpha = 0;
timer = 0;

menu_background_sprite = Logo; // Main Menu
menu_music = snd_LiberiFatali; // BGM to intro and main menu
menu_music_playing = false; // Track whether the music is already playing
bg_fade_alpha = 0; // Background starts fully transparent
bg_fade_started = false; // Track if the fade has started

menu_fade_alpha = 0; // Starts fully transparent
menu_fade_in_started = false; // Track if the fade-in has started


intro_images = [WoF_1, Logo2]; // Replace with your sprites
current_image_index = -1; // No image displayed initially
