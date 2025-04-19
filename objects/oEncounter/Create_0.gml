if (!variable_global_exists("game_initialized")) {
    EncounterInit();
    global.game_initialized = true;
}
