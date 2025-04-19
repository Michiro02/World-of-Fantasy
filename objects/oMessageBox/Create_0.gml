//create
// Initialize variables
message = "";
display_time = 60; // Adjust the time the message will be displayed (120 frames = 2 seconds at 60 FPS)
timer = 0;
player_instance = oPlayer; // Reference to the player instance


// Calculate the size of the message box based on the text length
var text_width = string_width(message) + 16; // Add some padding
var text_height = string_height(message) + 16; // Add some padding
box_width = max(102, text_width); 
box_height = max(32, text_height); 
