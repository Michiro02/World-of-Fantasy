// Create Event
display = "";
display_time = 90; // Adjust the time the message will be displayed (60 frames = 1 second at 60 FPS)
timer = 0;
player_instance = oPlayer; // Reference to the player instance

// Initialize padding and offsets
padding = 16; // Space between text and border
text_offset_x = 8; // Horizontal padding for text inside the box
text_offset_y = 12; // Vertical padding for text inside the box
box_distance = 84; // Distance from the player to the box (adjust as needed)

// Initial size and position setup
box_width = 100; // Default width; will be updated in the Step event
box_height = 32; // Default height; will be updated based on text
