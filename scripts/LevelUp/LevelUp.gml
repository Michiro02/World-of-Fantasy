var levelUpMessages = [];
global.lastLearnedSkills =[];

// Initialize global level-up summary array
global.levelUpSummary = [];

// Level-up function
function level_up(character) {
	    show_debug_message("Leveling up: " + character.name + " from level " + string(character.level));
    
	    // Track starting level for summary
	    var startingLevel = character.level;

	    // Initialize previous stats
	    var previousStats = {
	        level: character.level,
	        hpMax: character.hpMax,
	        mpMax: character.mpMax,
	        strength: character.strength,
	        magic: character.magic
	    };

	    // Perform multiple level-ups in a loop if necessary
	    while (character.xp >= character.xpNext && character.level < 110) {
	        character.xp -= character.xpNext;
	        character.level += 1;

	        // Increase stats
	        var hpIncrease = 60;
	        var mpIncrease = 20;
	        var strengthIncrease = 15; // Default strength increase
	        var magicIncrease = 0;     // Default magic increase

	        // Use switch case to adjust strength and magic based on character name
	        switch (character.name) {
	            case "Milan":
	            case "Hannah":
	            case "Jobelle":
	                strengthIncrease = 50; // Higher strength for these characters
	                break;

	            case "Andrei":
	            case "Kenneth":
	                strengthIncrease = 15; // Default strength
	                magicIncrease = 50;    // Higher magic for these characters
	                break;
	        }

	        // Update baseHpMax and baseMpMax
	        character.baseHpMax += hpIncrease;
	        character.baseMpMax += mpIncrease;

	        // Update hpMax and mpMax (including weapon bonuses)
	character.hpMax = character.baseHpMax + (character.equippedWeapon != undefined ? character.equippedWeapon.hpBonus : 0);
	character.mpMax = character.baseMpMax + (character.equippedWeapon != undefined ? character.equippedWeapon.mpBonus : 0);
		
		
			// Cap hpMax and mpMax at 9999 (in case weapon bonuses push them over)
	        character.hpMax = min(character.hpMax, 9999);
	        character.mpMax = min(character.mpMax, 9999);

	        // Update strength and magic
	        character.strength += strengthIncrease;
	        character.magic += magicIncrease;

	        // Restore HP and MP after leveling up
	        character.hp = character.hpMax;
	        character.mp = character.mpMax;

	        // Award skills if they hit the correct level
	        switch (character.name) {
	            case "Milan":
	                if (character.level == 65 && !array_contains(character.actions, global.actionLibrary.icesword)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.icesword;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice Sword!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice Sword");
	                }
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.Assess2)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Assess2;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Assess!";
						array_push(global.lastLearnedSkills, character.name + " learned Assess");
	                }
	                if (character.level == 75 && !array_contains(character.actions, global.actionLibrary.Stormstrike)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Stormstrike;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Stormstrike!";
						array_push(global.lastLearnedSkills, character.name + " learned Stormstrike");
	                }
	                if (character.level == 80 && !array_contains(character.actions, global.actionLibrary.excalibur)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.excalibur;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Excalibur!";
						array_push(global.lastLearnedSkills, character.name + " learned Excalibur");
	                }
					 if (character.level == 85 && !array_contains(character.actions, global.actionLibrary.NebulaStrike)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.NebulaStrike;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Nebula Strike!";
						array_push(global.lastLearnedSkills, character.name + " learned Nebula Strike");
	                }
					if (character.level == 90 && !array_contains(character.actions, global.actionLibrary.Vslash)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Vslash;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned V Slash!";
						array_push(global.lastLearnedSkills, character.name + " learned V Slash");
	                }
					if (character.level == 95 && !array_contains(character.actions, global.actionLibrary.VorpalStrike)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.VorpalStrike;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Vorpal Strike!";
						array_push(global.lastLearnedSkills, character.name + " learned Vorpal Strike");
	                }
	                break;
                
	            case "Andrei":
					if (character.level == 62 && !array_contains(character.actions, global.actionLibrary.resurrect)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.resurrect;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Resurrect!";
						array_push(global.lastLearnedSkills, character.name + " learned Resurrect");
	                }
	                if (character.level == 65 && !array_contains(character.actions, global.actionLibrary.ice)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.ice;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice");
	                }
	                
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.fira)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.fira;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Fira!";
						array_push(global.lastLearnedSkills, character.name + " learned Fira");
	                }
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.cura)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.cura;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Heal 2!";
						array_push(global.lastLearnedSkills, character.name + " learned Heal 2");
	                }
	                if (character.level == 75 && !array_contains(character.actions, global.actionLibrary.ice2)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.ice2;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice 2!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice 2");
	                }
					if (character.level == 78 && !array_contains(character.actions, global.actionLibrary.Assess)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Assess;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Assess!";
						array_push(global.lastLearnedSkills, character.name + " learned Assess");
	                }
					if (character.level == 80 && !array_contains(character.actions, global.actionLibrary.FireBall)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.FireBall;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Fireball!";
						array_push(global.lastLearnedSkills, character.name + " learned Fireball");
	                }
             
	                if (character.level == 82 && !array_contains(character.actions, global.actionLibrary.curaga)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.curaga;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Cure!";
						array_push(global.lastLearnedSkills, character.name + " learned Cure");
	                }
					if (character.level == 85 && !array_contains(character.actions, global.actionLibrary.firaga)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.firaga;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Firaga!";
						array_push(global.lastLearnedSkills, character.name + " learned Firaga");
	                }
	                if (character.level == 90 && !array_contains(character.actions, global.actionLibrary.ice3)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.ice3;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice 3!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice 3");
	                }
	                if (character.level == 95 && !array_contains(character.actions, global.actionLibrary.FireVortex)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.FireVortex;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Fire Vortex!";
						array_push(global.lastLearnedSkills, character.name + " learned Fire Vortex");
	                }
	                if (character.level == 100 && !array_contains(character.actions, global.actionLibrary.HolyStrike)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.HolyStrike;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Holy Strike!";
						array_push(global.lastLearnedSkills, character.name + " learned Holy Strike");
	                }
	                break;
                
	            case "Hannah":
	                if (character.level == 65 && !array_contains(character.actions, global.actionLibrary.icesword)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.icesword;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice Sword!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice Sword");
	                }
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.Assess2)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Assess2;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Assess!";
						array_push(global.lastLearnedSkills, character.name + " learned Assess");
	                }
				    if (character.level == 75 && !array_contains(character.actions, global.actionLibrary.Stormstrike)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Stormstrike;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Stormstrike!";
						array_push(global.lastLearnedSkills, character.name + " learned Stormstrike");
	                }	
	                if (character.level == 80 && !array_contains(character.actions, global.actionLibrary.lunge)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.lunge;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Lunge!";
						array_push(global.lastLearnedSkills, character.name + " learned Lunge");
	                }
	                if (character.level == 85 && !array_contains(character.actions, global.actionLibrary.TwisterLunge)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.TwisterLunge;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Twister Lunge!";
						array_push(global.lastLearnedSkills, character.name + " learned Twister Lunge");
	                }
					 if (character.level == 90 && !array_contains(character.actions, global.actionLibrary.dragonfury)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.dragonfury;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Dragon Fury!";
						array_push(global.lastLearnedSkills, character.name + " learned Dragon Fury");
	                }
	                break;
            
	            case "Kenneth":
	                if (character.level == 65 && !array_contains(character.actions, global.actionLibrary.meteor)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.meteor;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Meteor!";
						array_push(global.lastLearnedSkills, character.name + " learned Meteor");
	                }
				//	if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.WindCutter)) {
	            //        character.actions[array_length(character.actions)] = global.actionLibrary.WindCutter;
	            //        levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Wind Cutter!";
				//		array_push(global.lastLearnedSkills, character.name + " learned Wind Cutter");
	            //    }
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.Assess3)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Assess3;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Assess!";
						array_push(global.lastLearnedSkills, character.name + " learned Assess");
	                }
	                if (character.level == 75 && !array_contains(character.actions, global.actionLibrary.lightning)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.lightning;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Lightning!";
						array_push(global.lastLearnedSkills, character.name + " learned Lightning");
	                }
	                if (character.level == 80 && !array_contains(character.actions, global.actionLibrary.tornado)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.tornado;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Tornado!";
						array_push(global.lastLearnedSkills, character.name + " learned Tornado");
	                }
					 if (character.level == 85 && !array_contains(character.actions, global.actionLibrary.EarthQuake)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.EarthQuake;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Earthquake!";
						array_push(global.lastLearnedSkills, character.name + " learned Earthquake");
	                }
				
					if (character.level == 90 && !array_contains(character.actions, global.actionLibrary.MysticFlare)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.MysticFlare;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Mystic Flare!";
						array_push(global.lastLearnedSkills, character.name + " learned Mystic Flare");
	                }
	                break;
            
	            case "Jobelle":
	                if (character.level == 65 && !array_contains(character.actions, global.actionLibrary.DarkArrow)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.DarkArrow;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Dark Arrow!";
						array_push(global.lastLearnedSkills, character.name + " learned Dark Arrow");
					}
	                
	                if (character.level == 70 && !array_contains(character.actions, global.actionLibrary.Assess2)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.Assess2;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Assess!";
						array_push(global.lastLearnedSkills, character.name + " learned Assess");
	                }
					if (character.level == 75 && !array_contains(character.actions, global.actionLibrary.IceArrow)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.IceArrow;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Ice Arrow!";
						array_push(global.lastLearnedSkills, character.name + " learned Ice Arrow");					
	                }
	                if (character.level == 80 && !array_contains(character.actions, global.actionLibrary.VoidPiercer)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.VoidPiercer;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Void Piercer!";
						array_push(global.lastLearnedSkills, character.name + " learned Void Piercer");
	                }
	                if (character.level == 85 && !array_contains(character.actions, global.actionLibrary.CycloneShot)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.CycloneShot;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Cyclone Shot!";
						array_push(global.lastLearnedSkills, character.name + " learned Cyclone Shot");
	                }
					 if (character.level == 90 && !array_contains(character.actions, global.actionLibrary.SpectralRain)) {
	                    character.actions[array_length(character.actions)] = global.actionLibrary.SpectralRain;
	                    levelUpMessages[array_length(levelUpMessages)] = character.name + " learned Spectral Rain!";
						array_push(global.lastLearnedSkills, character.name + " learned Spectral Rain");
	                }
	                break;
	        }

	        // Update XP required for next level
	        character.xpNext = floor(character.xpNext * 1.1);
	    }
    
	    // If character hits the max level (110), set XP to match xpNext
	    if (character.level >= 110) {
	        character.xp = character.xpNext;  // Set XP to max
			character.maxLevelReached = true;
	        show_debug_message(character.name + " has reached level 110 and XP is set to " + string(character.xp) + "/" + string(character.xpNext));
	    }

	    // Add the level-up summary to the global summary once the final level is reached
	    global.levelUpSummary[array_length(global.levelUpSummary)] = {
	        name: character.name,
	        prevLevel: startingLevel,
	        newLevel: character.level,
	        prevHp: previousStats.hpMax,
	        newHp: character.hpMax,
	        prevMp: previousStats.mpMax,
	        newMp: character.mpMax,
	        prevStrength: previousStats.strength,
	        newStrength: character.strength,
	        prevMagic: previousStats.magic,
	        newMagic: character.magic
	    };
	}

	
	function gain_xp(character, xpAmount) {
	    show_debug_message("Gaining XP for " + character.name + ": " + string(xpAmount));

	    // Check if the character is already at max level
	    if (character.level >= 110) {
	        character.xp = character.xpNext;  // Set XP to the max (e.g., 900/900)
	        show_debug_message(character.name + " has reached the maximum level and XP is set to " + string(character.xp) + "/" + string(character.xpNext));
	        return; // Stop XP gain if max level is reached
	    }

	    character.xp += xpAmount;

	    // Check if the character should level up
	    if (character.xp >= character.xpNext) {
	        level_up(character);
	    }

	    show_debug_message("Finished gaining XP for " + character.name);
	}

	function award_party_xp(xpAmount) {
	    show_debug_message("Awarding XP to party: " + string(xpAmount));
	    for (var i = 0; i < array_length(global.party); i++) {
	        show_debug_message("Awarding XP to " + global.party[i].name);
	        gain_xp(global.party[i], xpAmount);
	    }
	    show_debug_message("Finished awarding XP to party");
	}