// Initialize variables
message = "";
display_time = 60; // Display time for the message (in frames)
timer = 0;

// Calculate the size of the message box based on the text length
var text_width = string_width(message) + 16; // Add some padding
var text_height = string_height(message) + 16; // Add some padding
box_width = max(105, text_width); 
box_height = max(32, text_height); 
