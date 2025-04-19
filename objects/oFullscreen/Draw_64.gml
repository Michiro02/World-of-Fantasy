// Optional: Only apply this if scaling is in effect
if (global.screen_scale != 1) {
    // Reset projection matrix to your GUI size
    var mat_proj = matrix_build_orthographic(0, 0, 640, 500, -1, 1);
    matrix_set(matrix_projection, mat_proj);

    // Apply world matrix for scaling and offset
    var mat_world = matrix_build(global.screen_offset_x, global.screen_offset_y, 0, 0, 0, 0, global.screen_scale, global.screen_scale, 1);
    matrix_set(matrix_world, mat_world);
}
