// Collision with a wall
direction += 180;  // Reverse direction when hitting a wall
direction = direction mod 360;  // Keep the direction value within 0-360 degrees
