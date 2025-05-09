function scr_reset_globals() {
    // Reset money
    global.totalMoney = 1000;
	
	//party reset
   global.party = 
[
    {
        name: "Milan",
        portrait: pMilan,
        role: "Swordsman",
        allowedWeaponTypes: ["Sword"],
        equippedWeapon: undefined,
        level: 60,
        xp: 50,
        xpNext: 90,
		maxLevelReached: false,
        hp: 2000,
        hpMax: 2000,
        mp: 1500,
        mpMax: 1500,
		baseHpMax: 2000,
		baseMpMax: 1500,
        weaknesses: [""],
        resistances: [""],
        absorbs: [""],
        strength: 550,
        magic: 0,
        paralyzed: false,         
        paralyzeTurns: 0,         
        sprites: { idle: sMilanIdle, idle2: sMilanIdle2, attack: sMilanAttack, defend: sMilanDefend, down: sMilanDown, jump: sHanJump,
				   victory: sMilanVictory},
        actions: [global.actionLibrary.attackSlash, 
                  global.actionLibrary.flamesword,
                  global.actionLibrary.defend,
                  global.actionLibrary.escape]
    },
    {
        name: "Andrei",
        portrait: pAndrei,
        role: "White Mage",
        allowedWeaponTypes: ["Staff"],
        equippedWeapon: undefined,
        level: 60,
        xp: 0,
        xpNext: 95,
		maxLevelReached: false,
        hp: 1450,
        hpMax: 1450,
        mp: 1700,
        mpMax: 1700,
		baseHpMax: 1450,
		baseMpMax: 1700,
        weaknesses: [""],
        resistances: [""],
        absorbs: [""],
        strength: 350,
        magic: 500,
        paralyzed: false,         
        paralyzeTurns: 0,        
        sprites: { idle: sAndreiIdle, idle2: sAndreiIdle2, attack: sAndreiAttack, cast: sAndreiCast, down: sAndreiDead },
        actions: [global.actionLibrary.attack, 
                  global.actionLibrary.fire, 
                  global.actionLibrary.cure, 
                  global.actionLibrary.escape]
    },
    {
        name: "Hannah",
        portrait: pHan,
        role: "Dragoon",
        allowedWeaponTypes: ["Sword", "Spear"],
        equippedWeapon: undefined,
        level: 60,
        xp: 0,
        xpNext: 100,
		maxLevelReached: false,
        hp: 1500,
        hpMax: 1500,
        mp: 1500,
        mpMax: 1500,
		baseHpMax: 1500,
		baseMpMax: 1500,
        weaknesses: [""],
        resistances: [""],
        absorbs: [""],
        strength: 600,
        magic: 0,
        paralyzed: false,        
        paralyzeTurns: 0,         
        sprites: { idle: sHanIdle, idle2: sHanIdle2, attack: sHanAttack, cast: sHanIdle, down: sHanDown, spear: sHanLunge, jump: sHanJump },
        actions: [global.actionLibrary.attack, 
                  global.actionLibrary.flamesword, 
                  global.actionLibrary.Jump, 
                  global.actionLibrary.escape]
    },
    {
        name: "Kenneth",
        portrait: pKenneth,
        role: "Summoner",
        allowedWeaponTypes: ["Book"],
        equippedWeapon: undefined,
        level: 60,
        xp: 0,
        xpNext: 105,
		maxLevelReached: false,
        hp: 1450,
        hpMax: 1450,
        mp: 2030,
        mpMax: 2030,
		baseHpMax: 1450,
		baseMpMax: 2030,
        weaknesses: [""],
        resistances: [""],
        absorbs: [""],
        strength: 350,
        magic: 600,
        paralyzed: false,        
        paralyzeTurns: 0,         
        sprites: { idle: sKennethIdle, idle2: sKennethIdle2, attack: sKennethAttack, cast: sKennethCast, down: sKennethDown },
        actions: [global.actionLibrary.attack, 
                  global.actionLibrary.shiva, 
                  global.actionLibrary.ifrit, 
                  global.actionLibrary.escape]
    },
    {
        name: "Jobelle",
        portrait: pJobelle,
        role: "Archer",
        allowedWeaponTypes: ["Bow"],
        equippedWeapon: undefined,
        level: 60,
        xp: 0,
        xpNext: 110,
		maxLevelReached: false,
        hp: 1500,
        hpMax: 1500,
        mp: 1500,
        mpMax: 1500,
		baseHpMax: 1500,
		baseMpMax: 1500,
        weaknesses: [""],
        resistances: [""],
        absorbs: [""],
        strength: 500,
        magic: 0,
        paralyzed: false,         
        paralyzeTurns: 0,         
        sprites: { idle: sJobelleIdle, idle2: sJobelleIdle2, attack: sJobelleAttack, cast: sJobelleIdle, down: sJobelleDead, spear: sJobelleAttack },
        actions: [global.actionLibrary.attack, 
                  global.actionLibrary.AimShot,
                  global.actionLibrary.escape]
    }
]


	//Reset Enemy
EnemyData();
	
    // Reset inventory
    global.inventory = [
	[global.actionLibrary.potion, 2],
	[global.actionLibrary.revive, 2],
	[global.actionLibrary.ether, 2]
	];

    // Reset weapon inventory
    global.weaponInventory = [];

    // Reset side quest flags
    global.dog_found = false;
    global.dog_reward_given = false;

    // Reset defeated flags
    global.cerberusDefeated = false;
    global.bossDefeated = false;
	global.gigatoaDefeated = false;
    global.fourfiendsDefeated = false;
	global.warringtriadDefeated = false;
	global.npcDialogueComplete = false;
	global.BahamutDefeated = false;
	global.LeviathanDefeated = false;

}