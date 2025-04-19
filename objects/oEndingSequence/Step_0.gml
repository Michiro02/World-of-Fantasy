
// Timer to trigger the sequence
if (!sequence_triggered) {
    sequence_timer -= 1;
    if (sequence_timer <= 0) {
        // Create the sequence on a specific layer at a specific position
        my_sequence_id = layer_sequence_create("Assets_1", x + 275, y + 255, Ending); // Replace "seqCredits" with your sequence asset name
        sequence_triggered = true;  // Ensure the sequence is only triggered once
    }
}