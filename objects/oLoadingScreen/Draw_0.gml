// Draw event for oLoadingScreen

// Get the current camera or viewport position (usually view_xview and view_yview if using viewports)
var viewX = camera_get_view_x(view_camera[0]);  // Get the x position of the camera
var viewY = camera_get_view_y(view_camera[0]);  // Get the y position of the camera

// Adjust the loading screen drawing based on the camera position
draw_self();  // Draw the sprite if you have one
draw_sprite(LoadingScreen, 0, viewX, viewY);  // Position the loading screen at the top-left of the viewport

// If using text:
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_font(fnM5x7);
draw_set_color(c_white);
// Draw the loading text in the center of the viewport
draw_text(viewX + 160, viewY + 110, loadingText);  // Adjusted for viewport size (320x220)

// Draw the animated characters
draw_sprite(MilanRun, -1, viewX + 100, viewY + 130);     
draw_sprite(AndreiRun, -1, viewX + 120, viewY + 130);   
draw_sprite(HannahRun, -1, viewX + 140, viewY + 130);    
draw_sprite(KennethRun, -1, viewX + 160, viewY + 130);   
draw_sprite(JobelleRun, -1, viewX + 180, viewY + 130);  

// Reset alignment to default values after drawing text
draw_set_halign(fa_left);
draw_set_valign(fa_top);
