randomize();
global.totalMoney = 1000;
global.dog_found = false;
global.dog_reward_given = false;
global.gigatoaDefeated = false;
global.npcDialogueComplete = false;
global.newDialogue = false;


global.enemyInitialSetup = false;
global.volume = 1; // Full volume initially
audio_master_gain(global.volume); // Set initial volume

// Initialize UI state
global.ui_state = 0;
global.ui_message = "";
global.ui_timer = 0;


//for not respawning the enemy again
if (!variable_global_exists("global.sephirothDefeated")) {
    global.sephirothDefeated = false;
}

if (!variable_global_exists("global.warringtriadDefeated")) {
    global.warringtriadDefeated = false;
}

if (!variable_global_exists("global.fourfiendsDefeated")) {
    global.fourfiendsDefeated = false;
}

if (!variable_global_exists("global.LeviathanDefeated")) {
    global.LeviathanDefeated = false;
}

if (!variable_global_exists("global.BahamutDefeated")) {
    global.BahamutDefeated = false;
}

if (!variable_global_exists("global.bossDefeated")) {
    global.bossDefeated = false;
}

if (!variable_global_exists("global.gilgameshDefeated")) {
    global.gilgameshDefeated = false;
}

if (!variable_global_exists("global.rokorDefeated")) {
    global.rokorDefeated = false;
}

if (!variable_global_exists("global.wallDefeated")) {
    global.wallDefeated = false;
}

if (!variable_global_exists("global.chestDefeated")) {
    global.chestDefeated = false;
}

if (!variable_global_exists("global.cerberusDefeated")) {
    global.cerberusDefeated = false;
}

if (!variable_global_exists("global.statueDefeated")) {
    global.statueDefeated = false;
}
//charging skill
global.Countdown = 10;
