function EnemyData(){

//Enemy Data
global.enemies =
{
	slimeG: 
	{
		name: "Slime",
		hp: 900,
		hpMax: 900,
		mp: 0,
		mpMax: 0,
		strength: 115,
		magic: 2,
		sprites: { idle: sSlime, attack: sSlimeAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire","True damage","Dark"],
		resistances: [" "],
		absorbs: [" "],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 40,
		moneyDrop: 30,
		sound: undefined,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 },  // 30% chance to drop an ether
		],
		 AIscript : function()
        {
			 // Randomly select an action from the available actions
	        var _action = actions[irandom(array_length(actions) - 1)];
        
	        // Filter the party members to find those who are still alive
	        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
	            return (_unit.hp > 0);
	        });

	        // Select a random target from the filtered list of living party members
	        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

	        // Return the chosen action and the target
	        return [_action, _target];
	    }
	},
	bat: 
	{
		name: "Bat",
		hp: 1015,
		hpMax: 1015,
		mp: 0,
		mpMax: 0,
		strength: 114,
		magic: 5,
		weaknesses: ["Electric", "True damage"],
		resistances: ["Ice"],
		absorbs: [" "],
		sprites: { idle: sBat, attack: sBatAttack},
		actions: [global.actionLibrary.attack],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 80,
		moneyDrop: 45,
		sound: undefined,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 }  // 30% chance to drop an ether
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	},
	mush: 
	{
		name: "Mushroom",
    hp: 1130,
    hpMax: 1130,
    mp: 0,
    mpMax: 0,
    strength: 120,
	magic: 10,
	weaknesses: ["Fire","True damage","Dark"],
	resistances: [" "],
	absorbs: [" "],
    sprites: { idle: sMushroomIdle, attack: sMushroomAttack },
    actions: [global.actionLibrary.attack],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],
    xpValue: 120,
	moneyDrop: 152,
	sound: undefined,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 }  // 30% chance to drop an ether
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	},
	Gatoris: 
	{
		name: "Gatoris",
		hp: 12000,
		hpMax: 12000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sGatoris, attack: sGatorisAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire","Dark","Heavy damage", "True damage"],
		resistances: ["Ice", "Water"],
		absorbs: [ ],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 300,
		moneyDrop: 290,
		sound: undefined,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	Skyhawk: 
	{
		name: "Skyhawk",
		hp: 12000,
		hpMax: 12000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sSkyhawk, attack: sSkyhawk},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire","Dark","Heavy damage", "Wind", "True damage"],
		resistances: ["Water"],
		absorbs: [ ],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 360,
		moneyDrop: 320,
		sound: undefined,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	Blazefang: 
	{
		name: "Blazefang",
		hp: 20000,
		hpMax: 20000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sBlazefang, attack: sBlazefangAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Ice","Dark","Water", "True damage"],
		resistances: [ ],
		absorbs: ["Fire"],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 620,
		moneyDrop: 820,
		sound: snd_ExtraBossTheme,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30},
			{ item: global.actionLibrary.Remedy, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	},
	golem: 
	{
		name: "Golem",
		hp: 22100,
		hpMax: 22100,
		mp: 0,
		mpMax: 0,
		strength: 700,
		magic: 2,
		sprites: { idle: sGolem, attack: sGolemAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Water","True damage","Wind"],
		resistances: ["Fire"],
		absorbs: [" "],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 800,
		moneyDrop: 900,
		sound: snd_ExtraBossTheme,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 },  // 30% chance to drop an ether
		],
		 AIscript : function()
        {
			 // Randomly select an action from the available actions
	        var _action = actions[irandom(array_length(actions) - 1)];
        
	        // Filter the party members to find those who are still alive
	        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
	            return (_unit.hp > 0);
	        });

	        // Select a random target from the filtered list of living party members
	        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

	        // Return the chosen action and the target
	        return [_action, _target];
	    }
	},
	Lynxara: 
	{
		name: "Lynxara",
		hp: 20000,
		hpMax: 20000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sLynxara, attack: sLynxaraAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["True damage","Dark","Electric","Heavy damage"],
		resistances: ["Ice", "Water"],
		absorbs: [ ],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 660,
		moneyDrop: 820,
		sound: snd_ExtraBossTheme,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30},
			{ item: global.actionLibrary.Remedy, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	Tuskbreaker: 
	{
		name: "Tusk",
		hp: 25000,
		hpMax: 25000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sTuskBreaker, attack: sTuskBreaker},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire","Dark","Electric", "True damage"],
		resistances: ["Heavy damage", "Water"],
		absorbs: [ ],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 630,
		moneyDrop: 990,
		sound: snd_ExtraBossTheme,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	tonberry: 
	{
		name: "Tonberry",
		hp: 30000,
		hpMax: 30000,
		mp: 0,
		mpMax: 0,
		strength: 115,
		magic: 2,
		sprites: { idle: sTonberry, attack: sTonberryAttack},
		actions: [global.actionLibrary.tonberryAttack],
		weaknesses: ["Fire", "True damage","Dark"],
		resistances: [" "],
		absorbs: [" "],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 1500,
		moneyDrop: 1820,
		sound: snd_ExtraBossTheme,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	IronGiant: 
	{
		name: "Iron Giant",
		hp: 70000,
		hpMax: 70000,
		mp: 0,
		mpMax: 0,
		strength: 815,
		magic: 2,
		sprites: { idle: sIronGiant, attack: sIronGiantAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire","Dark","Heavy damage","True damage"],
		resistances: ["Ice", "Water"],
		absorbs: ["Electric"],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 2500,
		moneyDrop: 2020,
		sound: snd_IronGiant,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 50},
			{ item: global.actionLibrary.Remedy, chance: 50}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	RedGiant: 
	{
		name: "Red Giant",
		hp: 80000,
		hpMax: 80000,
		mp: 0,
		mpMax: 0,
		strength: 915,
		magic: 2,
		sprites: { idle: sRedGiant, attack: sRedGiantAttack},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Water","Ice","True damage"],
		resistances: ["Fire"],
		absorbs: [" "],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 2900,
		moneyDrop: 2020,
		sound: snd_IronGiant,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 50},
			{ item: global.actionLibrary.Remedy, chance: 50}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	Mimic: 
	{
		name: "Mimic",
		hp: 70000,
		hpMax: 70000,
		mp: 0,
		mpMax: 0,
		strength: 415,
		magic: 2,
		sprites: { idle: sMimic, attack: sMimic},
		actions: [global.actionLibrary.attack],
		weaknesses: ["Fire", "True damage", "Electric"],
		resistances: ["Water"],
		absorbs: ["Ice"],
		preBattleDialogue: [],
        midBattleDialogue: [],
        deathDialogue: [],
		xpValue : 2500,
		moneyDrop: 3090,
		nextEnemy: noone,
		drops: [
			{ item: global.actionLibrary.potion, chance: 50 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 50 },  // 50% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 30}
		],
		AIscript : function()
		{
			//attack random party member
			var _action = actions[0];
			var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
			{
				return (_unit.hp > 0);
			});
			var _target = _possibleTargets[irandom(array_length(_possibleTargets)-1)];
			return [_action, _target];
		}
	}
	,
	cerberus: 
{
    name: "Cerberus",
    hp: 200000,
    hpMax: 200000,
    mp: 0,
    mpMax: 0,
    strength: 950,
	magic: 750,
    weaknesses: ["Ice", "Water", "Heavy damage", "True damage"],
	resistances: ["Dark", "Wind", "Electric"],
	absorbs: ["Fire"],
    sprites: { idle: sCerberus, attack: sCerberusAttack, cast: sCerberusAttack },
    actions: [global.actionLibrary.ClawSlash,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.BossAblaze, 
              global.actionLibrary.BossVortex, 
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.Enemyfire,
			  global.actionLibrary.BossMagma
			  ],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 7220,
	moneyDrop: 5225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, 
			{ item: global.actionLibrary.ether, chance: 100 },  
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.BossVortexAll)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	demon: 
{
    name: "Deity III",
    hp: 500000,
    hpMax: 500000,
    mp: 0,
    mpMax: 0,
    strength: 950,
	magic: 1300,
    weaknesses: ["Ice", "Water", "Heavy damage", "True damage"],
	resistances: ["Dark", "Wind", "Electric"],
	absorbs: ["Fire"],
    sprites: { idle: sWarringTriad1, attack: sWarringTriad1Attack, cast: sWarringTriad1Attack },
    actions: [global.actionLibrary.BossSmash, 
			  global.actionLibrary.BossAblaze,
			  global.actionLibrary.BossVortex,
			  global.actionLibrary.EclipseSurgeAll,
			  global.actionLibrary.RagnarokStrike,
			  global.actionLibrary.BossVortexAll
			  ],
	preBattleDialogue: ["Milan: Just like Thalor said...", "Milan: The Warring Triad is different",
						"Milan: from the enemies we fought."],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 20220,
	moneyDrop: 15225,
	nextEnemy: "fiend",
	drops: [
			{ item: global.actionLibrary.XEther, chance: 100 }, 
			{ item: global.actionLibrary.HighPotion, chance: 100 },  
			{ item: global.actionLibrary.HighElixir, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100},
			{ item: global.actionLibrary.XEther, chance: 100 }, 
			{ item: global.actionLibrary.HighPotion, chance: 100 },  
			{ item: global.actionLibrary.HighElixir, chance: 100},
			{ item: global.actionLibrary.XEther, chance: 100 }, 
			{ item: global.actionLibrary.HighPotion, chance: 100 },  
			{ item: global.actionLibrary.HighElixir, chance: 100},
			{ item: global.actionLibrary.XEther, chance: 100 }, 
			{ item: global.actionLibrary.HighPotion, chance: 100 },  
			{ item: global.actionLibrary.HighElixir, chance: 100},
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.BossVortexAll || _action == global.actionLibrary.EclipseSurgeAll
			 || _action == global.actionLibrary.RagnarokStrike)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	fiend: 
{
    name: "Deity II",
    hp: 600000,
    hpMax: 600000,
    mp: 0,
    mpMax: 0,
    strength: 950,
	magic: 1450,
    weaknesses: ["Ice", "Water", "Heavy damage", "True damage"],
	resistances: ["Dark", "Wind", "Electric"],
	absorbs: ["Fire"],
    sprites: { idle: sWarringTriad2, attack: sWarringTriad2Attack, cast: sWarringTriad2Attack },
    actions: [global.actionLibrary.BossSmash,
			  global.actionLibrary.BossVortex,
			  global.actionLibrary.BossAblaze,
			  global.actionLibrary.RagnarokStrike,
			  global.actionLibrary.EclipseSurgeAll,
			  global.actionLibrary.EternalFrost,
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.SephLightningAll
			  ],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: "goddess",
	music: snd_Phase2,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
   AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.BossVortexAll || _action == global.actionLibrary.EclipseSurgeAll
			 || _action == global.actionLibrary.RagnarokStrike || _action == global.actionLibrary.EternalFrost
			 || _action == global.actionLibrary.SephLightningAll)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	goddess: 
{
    name: "Deity I",
    hp: 700000,
    hpMax: 700000,
    mp: 0,
    mpMax: 0,
    strength: 950,
	magic: 1750,
    weaknesses: ["Heavy damage","True damage"],
	resistances: ["Dark","Water","Fire","Wind"],
	absorbs: ["Electric", "Ice"],
    sprites: { idle: sWarringTriad3, attack: sWarringTriad3Attack, cast: sWarringTriad3Attack },
    actions: [global.actionLibrary.BossSmash,
			  global.actionLibrary.BossAblaze,
			  global.actionLibrary.BossVortex,
			  global.actionLibrary.DivineThunder,
			  global.actionLibrary.EclipseSurgeAll,
			  global.actionLibrary.EternalFrost,
			  global.actionLibrary.RagnarokStrike,
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.BossAblazeAll
			  ],
	preBattleDialogue: ["Milan: The final statue...", "Milan: Such immense presence.", "Hannah: We can do this, I'm sure of it.",
						"Andrei: Let's finish this once and for all."],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: "kefka",
	music: snd_Phase3,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript : function()
        {
			
	    // Filter alive party members at the start
	    var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
	        return (_unit.hp > 0);
	    });
	    var _aliveCount = array_length(_possibleTargets);

	    // 20% chance to cast Heartless Angel, either on two or up to four targets
	    if (irandom(100) < 20) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target two or up to four members, depending on availability
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets;
            
	            if (_aliveCount >= 3 && irandom(1) == 0) {
	                _targets = [_possibleTargets[0], _possibleTargets[1], _possibleTargets[2]];
	            } else {
	                // Target two members if fewer than four are available or random choice prefers two
	                _targets = [_possibleTargets[0], _possibleTargets[1]];
	            }
            
	            return [global.actionLibrary.HeartlessAngel, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.HeartlessAngel, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Paralyze on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.EnemyParalyze, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.EnemyParalyze, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Life Drainer on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.BossLifeDrainer, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.BossLifeDrainer, [_possibleTargets[0]]];
	        }
	    }
        
        // Select a random action if no other conditions are met
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.RagnarokStrike || 
            _action == global.actionLibrary.EclipseSurgeAll ||
            _action == global.actionLibrary.DivineThunder || 
            _action == global.actionLibrary.EternalFrost ||
			_action == global.actionLibrary.BossAblazeAll ||
			_action == global.actionLibrary.BossVortexAll)
        {
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
        }
        else
        {
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
	kefka: 
{
    name: "Exarch",
    hp: 900000,
    hpMax: 900000,
    mp: 0,
    mpMax: 0,
    strength: 950,
	magic: 1950,
    weaknesses: ["Heavy damage","True damage"],
	resistances: ["Dark", "Electric", "Water", "Wind"],
	absorbs: ["Fire", "Ice"],
    sprites: { idle: sKefka, attack: sKefkaAttack, cast: sKefkaAttack },
    actions: [global.actionLibrary.BossSmash, 
			  global.actionLibrary.BossMagma,
			  global.actionLibrary.BossVortex,
			  global.actionLibrary.BossAblaze,
	          global.actionLibrary.DivineThunder,
			  global.actionLibrary.EclipseSurgeAll,
			  global.actionLibrary.RagnarokStrike,
			  global.actionLibrary.JudgmentRay,
			  global.actionLibrary.EternalFrost,
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.BossAblazeAll,
			  global.actionLibrary.BossMagmaAll
			  ],
	preBattleDialogue: ["Milan: Oh no, the Exarch awakens.", "Hannah: I suspect this will happen.", "Kenneth: But since the Exarch has awakened..", 
	                    "Kenneth: we can now finish this.", "Jobelle: That's right.", "Jobelle: So that everyone will be saved.", "Andrei: But we need to be careful here..",
						"Andrei: since the Exarch has different power.", "Andrei: compared to the 3 statues awhile ago."],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: noone,
	music: snd_Phase4,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript : function()
        {
			
	    // Filter alive party members at the start
	    var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
	        return (_unit.hp > 0);
	    });
	    var _aliveCount = array_length(_possibleTargets);

	    // 20% chance to cast Heartless Angel, either on two or up to four targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target two or up to four members, depending on availability
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets;
            
	            if (_aliveCount >= 3 && irandom(1) == 0) {
	                _targets = [_possibleTargets[0], _possibleTargets[1], _possibleTargets[2]];
	            } else {
	                // Target two members if fewer than four are available or random choice prefers two
	                _targets = [_possibleTargets[0], _possibleTargets[1]];
	            }
            
	            return [global.actionLibrary.HeartlessAngel, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.HeartlessAngel, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Paralyze on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.EnemyParalyze, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.EnemyParalyze, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Life Drainer on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.BossLifeDrainer, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.BossLifeDrainer, [_possibleTargets[0]]];
	        }
	    }
        
        // Select a random action if no other conditions are met
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.EternalFrost || 
            _action == global.actionLibrary.RagnarokStrike ||
            _action == global.actionLibrary.DivineThunder || 
            _action == global.actionLibrary.JudgmentRay ||
			_action == global.actionLibrary.EclipseSurgeAll ||
			_action == global.actionLibrary.BossMagmaAll ||
			_action == global.actionLibrary.BossAblazeAll ||
			_action == global.actionLibrary.BossVortexAll)
        {
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
        }
        else
        {
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
	rubicante: 
{
    name: "Rubicante",
    hp: 150000,
    hpMax: 150000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 850,
    weaknesses: ["Ice", "True damage"],
	resistances: ["Dark", "Wind", "Electric", "Water"],
	absorbs: ["Fire"],
    sprites: { idle: sRubicante, attack: sRubicanteAttack, cast: sRubicanteAttack },
    actions: [global.actionLibrary.BossAttack,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.BossAblaze, 
              global.actionLibrary.BossVortex, 
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.Enemyfire,
			  global.actionLibrary.BossMagma,
			  global.actionLibrary.BossMeteor
			  ],
	preBattleDialogue: [],
    midBattleDialogue: ["Rubicante: No! This can't be happening!"],
	deathDialogue: ["Rubicante: Unbelievable..."],
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100},
			{ item: global.actionLibrary.HighElixir, chance: 100}
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.BossVortexAll || _action == global.actionLibrary.BossMeteor)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	cagnazzo: 
{
    name: "Cagnazzo",
    hp: 150000,
    hpMax: 150000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 850,
    weaknesses: ["Electric", "True damage", "Fire"],
	resistances: ["Heavy damage"],
	absorbs: ["Water"],
    sprites: { idle: sCagnazzo, attack: sCagnazzoAttack, cast: sCagnazzoAttack },
    actions: [global.actionLibrary.BossAttack,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.LevTsunami,
			  global.actionLibrary.whirlpool,
			  global.actionLibrary.whirlpoolAll
			  ],
	preBattleDialogue: [],
    midBattleDialogue: ["Cagnazzo: Impossible!"],	
	deathDialogue: ["Cagnazzo: We failed again...."],
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100},
			{ item: global.actionLibrary.HighElixir, chance: 100}
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.LevTsunami || _action == global.actionLibrary.whirlpoolAll)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	miglione: 
{
    name: "Miglione",
    hp: 150000,
    hpMax: 150000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 850,
    weaknesses: ["Fire", "True damage", "Wind"],
	resistances: [" "],
	absorbs: ["Ice"],
    sprites: { idle: sMilonZ, attack: sMilonZAttack, cast: sMilonZAttack },
    actions: [global.actionLibrary.BossAttack,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.BossEarthQuake,
			  global.actionLibrary.Enemyice,
			  global.actionLibrary.Enemyfire
			  ],
	preBattleDialogue: [],
    midBattleDialogue: ["Miglione: You're still standing?!"],
	deathDialogue: ["Miglione: So strong..."],
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.BossEarthQuake)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	barbariccia: 
{
    name: "Barbariccia",
    hp: 150000,
    hpMax: 150000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 850,
    weaknesses: ["Electric", "True damage"],
	resistances: ["Dark", "Wind", "Water"],
	absorbs: [" "],
    sprites: { idle: sBarbariccia, attack: sBarbaricciaAttack, cast: sBarbaricciaAttack },
    actions: [global.actionLibrary.BossAttack,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.SephLightning,
			  global.actionLibrary.SephTornado,
			  global.actionLibrary.SephTornadoAll
			  ],
	preBattleDialogue: [],
    midBattleDialogue: ["Barbariccia: This is outrageous..."],
	deathDialogue: ["Barbariccia: I didn't expect their strength.."],  
    xpValue: 3220,
	moneyDrop: 3225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript: function() {
         // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.SephTornadoAll)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	giga: 
{
    name: "Gigatoa",
    hp: 220000,
    hpMax: 220000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 850,
    weaknesses: ["Ice", "True damage","Wind"],
	resistances: ["Fire","Electric","Dark"],
	absorbs: [" "],
    sprites: { idle: sBoss, attack: sBossAttack, cast: sBossAttack },
    actions: [global.actionLibrary.BossAttack,
	          global.actionLibrary.BossSmash,
			  global.actionLibrary.BossAblaze, 
              global.actionLibrary.BossBeam,
			  global.actionLibrary.Enemyice, 
			  global.actionLibrary.Enemyfire
			  ],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 9220,
	moneyDrop: 6225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.revive, chance: 100},
			{ item: global.actionLibrary.Remedy, chance: 100}
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
    }
},
	giga2: 
	{
	    name: "Gigatoa",
	    hp: 300000,
	    hpMax: 300000,
	    mp: 0,
	    mpMax: 0,
	    strength: 950,
		magic: 1000,
	    weaknesses: ["True damage","Wind","Water"],
		resistances: ["Ice","Dark","Fire"],
		absorbs: [" "],
	    sprites: { idle: sFinBossPhase1, attack: sFinBossPhase1Attack, cast: sFinBossPhase1Attack },
	    actions: [global.actionLibrary.BossAttack,
		          global.actionLibrary.BossSmash,
				  global.actionLibrary.BossAblaze, 
	              global.actionLibrary.SephTornado,
				  global.actionLibrary.Enemyice, 
				  global.actionLibrary.Enemyfire,
				  global.actionLibrary.BossVortex,
				  global.actionLibrary.SephLightning,
				  global.actionLibrary.BossVortexAll,
				  global.actionLibrary.BossMagmaAll,
				  global.actionLibrary.SephLightningAll,
				  global.actionLibrary.SephTornadoAll,
				  global.actionLibrary.BossAblazeAll
				  ],
		preBattleDialogue: ["Gigatoa: You cannot defeat me.", "Gigatoa: Prepare for despair!"],
        midBattleDialogue: ["Gigatoa: What... This can't be happening!", "Gigatoa: You're stronger than I thought...",
							"Kenneth: Or maybe you're just not as strong", "Kenneth: as you think you are.", 
							"Gigatoa: Fools! We are still not done yet."],
        deathDialogue: ["Gigatoa: This is far from over."],		  
	    xpValue: 10220,
		moneyDrop: 7225,
		nextEnemy: noone,
		drops: [
				{ item: global.actionLibrary.HighPotion, chance: 100 }, 
				{ item: global.actionLibrary.ether, chance: 100 }, 
				{ item: global.actionLibrary.revive, chance: 100},
				{ item: global.actionLibrary.Remedy, chance: 100},
				{ item: global.actionLibrary.HighPotion, chance: 100 }, 
				{ item: global.actionLibrary.ether, chance: 100 }, 
				{ item: global.actionLibrary.revive, chance: 100},
				{ item: global.actionLibrary.Remedy, chance: 100},
				{ item: global.actionLibrary.HighPotion, chance: 100 }, 
				{ item: global.actionLibrary.ether, chance: 100 }, 
				{ item: global.actionLibrary.revive, chance: 100},
				{ item: global.actionLibrary.Remedy, chance: 100}
				
			],
	  // Flag to check if SephUlt has been cast after going below 50% HP
    castedUlt: false,

    AIscript: function() 
    {
        var hpPercentage = (hp / hpMax) * 100;

        // Check if HP is below 50% and Ult hasn't been cast yet
        if (hpPercentage < 50 && !castedUlt) 
        {
            // Set the flag to true, so Ult is cast only once at first below 50%
            castedUlt = true;
            //  casts Ult on all party members
            return [global.actionLibrary.BossEarthQuake, oBattle.partyUnits];
        }

        // After the first Ult cast, give a random chance to cast SephUlt again
        if (hpPercentage < 40) 
        {
            // Give a 20% chance to cast Ult
            if (irandom(100) < 20) 
            {
                return [global.actionLibrary.BossEarthQuake, oBattle.partyUnits];
            }
        }
			// Give a 20% chance to cast Paralyze on a single target
			if (irandom(100) < 20) 
			{
				// Filter the party members to find those who are still alive
				var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
					return (_unit.hp > 0);
				});
		
				// Ensure there is at least one possible target
				if (array_length(_possibleTargets) > 0) {
					// Select a random target from the filtered list of living party members
					var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];
			
					// Return the EnemyParalyze action with a single target
					return [global.actionLibrary.EnemyParalyze, [_target]];
				}
			}
			
	        // Select a random action if no other conditions are met
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.SephTornadoAll || 
            _action == global.actionLibrary.BossAblazeAll ||
            _action == global.actionLibrary.BossMagmaAll || 
            _action == global.actionLibrary.BossVortexAll ||
			_action == global.actionLibrary.SephLightningAll)
        {
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
        }
        else
        {
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
    giga3: 
	{
		name: "Gigatoa",
    hp: 700000,
    hpMax: 700000,
    mp: 0,
    mpMax: 0,
    strength: 1050,
	magic: 1300,
	weaknesses: ["True damage", "Electric"],
	resistances: ["Water", "Heavy damage", "Wind"],
	absorbs: ["Ice", "Fire"],
    sprites: { idle: sFinBoss, attack: sFinBossAttack, cast: sFinBossAttack },
    actions: [global.actionLibrary.BossSmash, 
	          global.actionLibrary.BossAblaze, 
			  global.actionLibrary.BossBeam, 
		      global.actionLibrary.Enemyice,
			  global.actionLibrary.SephTornado,
			  global.actionLibrary.BossMagma,
			  global.actionLibrary.BossAblazeAll,
			  global.actionLibrary.BossMagmaAll,
			  global.actionLibrary.BossVortex,
			  global.actionLibrary.BossVortexAll,
			  global.actionLibrary.SephLightning,
			  global.actionLibrary.SephLightningAll,
			  global.actionLibrary.BossEarthQuake
			  
			  ],
	preBattleDialogue: ["Gigatoa: The real battle begins here!", "Milan: Everyone...", "Milan: don't let your guard down."
						],
    midBattleDialogue: ["Gigatoa: You.. are really...","Gigatoa: pushing me to the limit!", "Milan: Stay strong, everyone!",
						"Milan: We can win this!"],
    deathDialogue: ["Gigatoa: No... this is absurd...!", "Milan: It's over, Gigatoa. We've won.","Milan: You're finished."],		  
    xpValue: 15920,
	moneyDrop: 8225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.XEther, chance: 100 },
			{ item: global.actionLibrary.HighElixir, chance: 100 },
			{ item: global.actionLibrary.HighPotion, chance: 100 },
			{ item: global.actionLibrary.XPotion, chance: 100 },
			{ item: global.actionLibrary.XEther, chance: 100 },
			{ item: global.actionLibrary.HighElixir, chance: 100 },
			{ item: global.actionLibrary.HighPotion, chance: 100 },
			{ item: global.actionLibrary.XPotion, chance: 100 }
		],
     AIscript : function()
        {
			
	    // Filter alive party members at the start
	    var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
	        return (_unit.hp > 0);
	    });
	    var _aliveCount = array_length(_possibleTargets);

	    // 20% chance to cast Heartless Angel, either on two or up to four targets
	    if (irandom(100) < 20) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target two or up to four members, depending on availability
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets;
            
	            if (_aliveCount >= 3 && irandom(1) == 0) {
	                _targets = [_possibleTargets[0], _possibleTargets[1], _possibleTargets[2]];
	            } else {
	                // Target two members if fewer than four are available or random choice prefers two
	                _targets = [_possibleTargets[0], _possibleTargets[1]];
	            }
            
	            return [global.actionLibrary.HeartlessAngel, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.HeartlessAngel, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Paralyze on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.EnemyParalyze, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.EnemyParalyze, [_possibleTargets[0]]];
	        }
	    }

	    // 20% chance to cast Life Drainer on one or two random targets
	    if (irandom(100) < 15) {
	        if (_aliveCount >= 2) {
	            // Randomly decide to target one or two members
	            _possibleTargets = array_shuffle(_possibleTargets);
	            var _targets = irandom(1) == 0 ? 
	                [_possibleTargets[0]] : 
	                [_possibleTargets[0], _possibleTargets[1]];
	            return [global.actionLibrary.BossLifeDrainer, _targets];
	        } else if (_aliveCount == 1) {
	            // Target the single member if only one is alive
	            return [global.actionLibrary.BossLifeDrainer, [_possibleTargets[0]]];
	        }
	    }
        
        // Select a random action if no other conditions are met
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.BossBeam || 
            _action == global.actionLibrary.BossAblazeAll ||
            _action == global.actionLibrary.BossMagmaAll || 
            _action == global.actionLibrary.BossVortexAll ||
			_action == global.actionLibrary.SephLightningAll ||
			_action == global.actionLibrary.BossEarthQuake)
        {
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
        }
        else
        {
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
	 leviathan: 
	{
		name: "Leviathan",
    hp: 80000,
    hpMax: 80000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 1000,
	weaknesses: ["Electric", "Fire","Dark","Wind","True damage"],
	resistances: ["Ice","Heavy damage"],
	absorbs: [" "],
    sprites: { idle: sLeviathan, attack: sLeviathanAttack, cast: sLeviathanAttack },
    actions: [global.actionLibrary.BossSmash,
			  global.actionLibrary.BossAttack,
	          global.actionLibrary.LevTsunami,
			  global.actionLibrary.whirlpool,
			  global.actionLibrary.whirlpoolAll,
			  ],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 1520,
	moneyDrop: 2225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 }  // 30% chance to drop an ether
		],
     AIscript : function()
        {
            // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.LevTsunami || _action == global.actionLibrary.whirlpoolAll)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    }
    ,
	 Bahamut: 
	{
		name: "Bahamut",
    hp: 200000,
    hpMax: 200000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 1000,
	weaknesses: ["Ice", "Water", "Dark", "Wind","True damage"],
	resistances: ["Fire", "Electric"],
	absorbs: [" "],
    sprites: { idle: sBahamut, attack: sBahamutAttack, cast: sBahamutAttack },
    actions: [global.actionLibrary.MegaFlare],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],
    xpValue: 3020,
	moneyDrop: 2225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 }  // 30% chance to drop an ether
		],
     AIscript : function()
        {
            // Select a random action
            var _action = actions[irandom(array_length(actions) - 1)];
            
            // Determine targets based on action
            var _targets;
            if (_action == global.actionLibrary.MegaFlare)
            {
                // Use skill on all party members
                _targets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
            }
            else
            {
                // For other skills, target a random party member
                var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index)
                {
                    return (_unit.hp > 0);
                });
                _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
            }

            return [_action, _targets];
        }
    },
	 sephiroth: 
	{
		name: "Sephiroth",
    hp: 300000,
    hpMax: 300000,
    mp: 0,
    mpMax: 0,
    strength: 550,
	magic: 1000,
	weaknesses: ["Fire", "Heavy damage", "Dark","True damage"],
	resistances: ["Wind","Water"],
	absorbs: [" "],
    sprites: { idle: SephirothIdle, attack: SephirothAtk, cast: SephirothCast},
    actions: [global.actionLibrary.SephSlash,
			  global.actionLibrary.SephSlashAll, 
			  global.actionLibrary.BossAblaze, 
			  global.actionLibrary.SephLightningAll, 
		      global.actionLibrary.Enemyice,
			  global.actionLibrary.BossMagma, 
			  global.actionLibrary.SephTornado,
			  global.actionLibrary.SephMeteor,

			  ],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 8100,
	moneyDrop: 8225,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.XEther, chance: 100 },
			{ item: global.actionLibrary.revive, chance: 100 },
			{ item: global.actionLibrary.HighPotion, chance: 100 },
			{ item: global.actionLibrary.HighElixir, chance: 100 },
			{ item: global.actionLibrary.HighEther, chance: 100 },
			
		],
	// Flag to check if SephUlt has been cast after going below 50% HP
    castedUlt: false,

    AIscript: function() 
    {
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.BossAblazeAll || _action == global.actionLibrary.SephLightningAll || 
            _action == global.actionLibrary.SephSlashAll || _action == global.actionLibrary.SephMeteor)
        {
            // Use skill on all party members
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
        } 
        else 
        {
            // For other skills, target a random party member
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
	
	 sephirothv2: 
	{
		name: "Sephiroth",
    hp: 1000000,
    hpMax: 1000000,
    mp: 0,
    mpMax: 0,
    strength: 1050,
	magic: 2000,
	weaknesses: ["Fire", "Heavy damage", "Dark","True damage"],
	resistances: ["Wind","Water"],
	absorbs: [" "],
    sprites: { idle: Sephirothv2Idle, attack: SephirothInvi, cast: Sephirothv2Cast, ulti: SephirothUlt},
    actions: [global.actionLibrary.SephSlashAllv2, 
			  global.actionLibrary.BossAblaze, 
			  global.actionLibrary.SephLightningAll, 
		      global.actionLibrary.Enemyice, 
			  global.actionLibrary.BossMagma, 
			  global.actionLibrary.SephTornado,
			  global.actionLibrary.SephMeteor,
			  global.actionLibrary.BossAblazeAll
			  ],
	preBattleDialogue: [],
    midBattleDialogue: ["Sephiroth: You're still standing?", "Milan: We told you we will defeat you.",
						"Sephiroth: Then let me show you something.."],
    deathDialogue: [],		  
    xpValue: 8100,
	moneyDrop: 8225,
	nextEnemy: noone,
	drops: [		
			{ item: global.actionLibrary.wipeout, chance: 100 },
			{ item: global.actionLibrary.revive, chance: 100 },
			{ item: global.actionLibrary.XPotion, chance: 100 },
			{ item: global.actionLibrary.HighElixir, chance: 100 },
			{ item: global.actionLibrary.XEther, chance: 100 },
			{ item: global.actionLibrary.revive, chance: 100 },
			{ item: global.actionLibrary.XPotion, chance: 100 },
			{ item: global.actionLibrary.HighElixir, chance: 100 },
			{ item: global.actionLibrary.XEther, chance: 100 }

		],
	// Flag to check if SephUlt has been cast after going below 50% HP
    castedUlt: false,

    AIscript: function() 
    {
        var hpPercentage = (hp / hpMax) * 100;

        // Check if HP is below 50% and SephUlt hasn't been cast yet
        if (hpPercentage < 50 && !castedUlt) 
        {
            // Set the flag to true, so SephUlt is cast only once at first below 50%
            castedUlt = true;
            // Sephiroth casts SephUlt on all party members
            return [global.actionLibrary.SephUlt, oBattle.partyUnits];
        }

        // After the first SephUlt cast, give a random chance to cast SephUlt again
        if (hpPercentage < 40) 
        {
            // Give a 30% chance to cast SephUlt
            if (irandom(100) < 20) 
            {
                return [global.actionLibrary.SephUlt, oBattle.partyUnits];
            }
        }

        // If not casting SephUlt, select a random action from the action list
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Determine targets based on action
        var _targets;
        if (_action == global.actionLibrary.BossAblazeAll || _action == global.actionLibrary.SephLightningAll || 
            _action == global.actionLibrary.SephSlashAllv2 || _action == global.actionLibrary.SephMeteor ||
            _action == global.actionLibrary.SephUlt)
        {
            // Use skill on all party members
            _targets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
        } 
        else 
        {
            // For other skills, target a random party member
            var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) 
            {
                return (_unit.hp > 0);
            });
            _targets = [_possibleTargets[irandom(array_length(_possibleTargets) - 1)]];
        }

        return [_action, _targets];
    }
},
	centipede: 
	{
		name: "Centipede",
    hp: 2345,
    hpMax: 2345,
    mp: 0,
    mpMax: 0,
    strength: 135,
	magic: 60,
	weaknesses: ["True damage","Dark","Water","Heavy damage"],
	resistances: ["Fire"],
	absorbs: [" "],
    sprites: { idle: sCentipede, attack: sCentipede },
    actions: [global.actionLibrary.ClawSlash, global.actionLibrary.EnemySmash, global.actionLibrary.Enemyice, 
			  global.actionLibrary.Enemyfire],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 283,
	moneyDrop: 155,
	sound: undefined,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 30 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 30 }  // 30% chance to drop an ether
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	},
	
	behemoth: 
	{
		name: "Behemoth",
    hp: 20000,
    hpMax: 20000,
    mp: 0,
    mpMax: 0,
    strength: 360,
	magic: 400,
	weaknesses: ["Ice","Heavy damage", "True damage","Dark"],
	resistances: ["Fire","Electric"],
	absorbs: [" "],
    sprites: { idle: sBehemoth, attack: sBehemothAttack, cast: sBehemothAttack },
    actions: [global.actionLibrary.ClawSlash, global.actionLibrary.EnemySmash, global.actionLibrary.BossAblaze, 
	global.actionLibrary.Enemyfire, global.actionLibrary.Enemyice],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],
    xpValue: 1520,
	moneyDrop: 502,
	sound: snd_ExtraBossTheme,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 100 },  // 30% chance to drop an ether
			{ item: global.actionLibrary.elixir, chance: 40 },
			{ item: global.actionLibrary.revive, chance: 40 },
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	},
	gilgamesh: 
	{
		name: "Gilgamesh",
    hp: 60000,
    hpMax: 60000,
    mp: 0,
    mpMax: 0,
    strength: 560,
	magic: 0,
	weaknesses: ["True damage", "Ice", "Wind", "Water", "Dark"],
	resistances: ["Fire","Heavy damage","Electric"],
	absorbs: [" "],
    sprites: { idle: sGilgamesh, attack: sGilgameshAttack, cast: sGilgameshAttack },
    actions: [global.actionLibrary.attack, global.actionLibrary.EnemySmash],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],
    xpValue: 2220,
	moneyDrop: 1102,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, 
			{ item: global.actionLibrary.ether, chance: 100 },  
			{ item: global.actionLibrary.elixir, chance: 100 },
			{ item: global.actionLibrary.revive, chance: 100 },
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	},
	rokor: 
	{
		name: "Rokor",
    hp: 60000,
    hpMax: 60000,
    mp: 0,
    mpMax: 0,
    strength: 560,
	magic: 560,
	weaknesses: ["Ice","True damage","Dark"],
	resistances: ["Fire","Wind","Water"],
	absorbs: [" "],
    sprites: { idle: sRokor, attack: sRokor, cast: sRokor },
    actions: [global.actionLibrary.ClawSlash, global.actionLibrary.EnemySmash, global.actionLibrary.BossAblaze,
			  global.actionLibrary.BossMagma],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 3220,
	moneyDrop: 1502,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 100 }, 
			{ item: global.actionLibrary.ether, chance: 100 },  
			{ item: global.actionLibrary.elixir, chance: 100 },
			{ item: global.actionLibrary.revive, chance: 100 },
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	},
	wall: 
	{
	name: "Evil Wall",
    hp: 46000,
    hpMax: 46000,
    mp: 0,
    mpMax: 0,
    strength: 415,
	magic: 350,
	weaknesses: ["Wind", "True damage","Electric","Heavy damage"],
	resistances: ["Dark"],
	absorbs: ["Fire"],
    sprites: { idle: sExtraBoss, attack: sExtraBossAttack, cast: sExtraBossAttack },
    actions: [global.actionLibrary.BossAttack, global.actionLibrary.BossAblaze, global.actionLibrary.BossSmash,
			  global.actionLibrary.Enemyfire, global.actionLibrary.Enemyice],
	preBattleDialogue: [],
    midBattleDialogue: [],
    deathDialogue: [],		  
    xpValue: 1835,
	moneyDrop: 836,
	nextEnemy: noone,
	drops: [
			{ item: global.actionLibrary.potion, chance: 60 }, // 50% chance to drop a potion
			{ item: global.actionLibrary.ether, chance: 60 }  // 30% chance to drop an ether
		],
    AIscript: function() {
        // Randomly select an action from the available actions
        var _action = actions[irandom(array_length(actions) - 1)];
        
        // Filter the party members to find those who are still alive
        var _possibleTargets = array_filter(oBattle.partyUnits, function(_unit, _index) {
            return (_unit.hp > 0);
        });

        // Select a random target from the filtered list of living party members
        var _target = _possibleTargets[irandom(array_length(_possibleTargets) - 1)];

        // Return the chosen action and the target
        return [_action, _target];
		}
	}
}

}