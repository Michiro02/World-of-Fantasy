enum MODE
{
	NEVER = 0,
	ALWAYS = 1,
	VARIES = 2,
}


//Action library
global.actionLibrary =
{
	//player attacks
	attack : 
	{
		name : "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackBonk,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			if (_targets[0].defending) _damage = ceil(_damage * 0.75);
			BattleChangeHP(_targets[0], -_damage);
		}		
	}
	,
	attackSlash :
	{
		name : "Attack",
		description : "{0} attacks!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackSlash,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			var _damage = ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
			if (_targets[0].defending) _damage = ceil(_damage * 0.75);
			BattleChangeHP(_targets[0], -_damage);
		}		
	},
	lunge : 
	{
		name : "Lunge",
		description : "{0} uses Lunge!",
		subMenu : "Skill",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "spear",
		effectSprite: sSpearEffect,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to physical
            if (array_contains(_targets[i].weaknesses, "Heavy damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for physical weakness
            }
			
			// Check if the target has resistance to physical
                if (array_contains(_targets[i].resistances, "Heavy damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs physical (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Heavy damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Heavy damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Heavy damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	TwisterLunge : 
	{
		name : "Twister Lunge",
		description : "{0} uses Twister Lunge!",
		subMenu : "Skill",
		mpCost : 250,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "spear",
		effectSprite: sAttackTwisterLunge,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_TwisterLunge,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to physical
            if (array_contains(_targets[i].weaknesses, "Wind"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for wind weakness
            }
			
			// Check if the target has resistance to physical
                if (array_contains(_targets[i].resistances, "Wind"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs physical (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Wind"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Wind"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Wind");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	Jump : 
	{
		name : "Jump",
		description : "{0} uses Jump!",
		subMenu : -1,
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "jump",
		effectSprite: sJump,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Jump,
		func : function(_user, _targets)
		{
		 // Make Hannah invisible at the start of the Jump
            _user.visible = false;

            // Loop through the targets and apply damage
            for (var i = 0; i < array_length(_targets); i++)
            {
                var _damage = irandom_range(500, 800);
                _damage += _user.strength * 0.8;  // Scale damage by strength

                // Check for weaknesses, resistances, or absorbs
                if (array_contains(_targets[i].weaknesses, "Heavy damage"))
                {
                    _damage = ceil(_damage * 2.5); // Increase for physical weakness
                }
                if (array_contains(_targets[i].resistances, "Heavy damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce for physical resistance
                }
                if (array_contains(_targets[i].absorbs, "Heavy damage"))
                {
                    var _heal = ceil(_damage);  // Heal instead of damage
                    BattleChangeHP(_targets[i], _heal,0,"Heavy damage");
                    continue;  // Skip the damage text for healing
                }

                // If multiple targets, reduce damage slightly
                if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);

                // Apply damage
                BattleChangeHP(_targets[i], -_damage,0,"Heavy damage");
            }

            // Deduct MP cost from user
            BattleChangeMP(_user, -mpCost);

            // Bring Hannah back after the effect sprite has completed
            with (_user)
            {
                visible = true;  // Reappear after jump
                sprite_index = sprites.idle;  // Reset to idle sprite
                image_index = 0;  // Reset frame
		}
	}
},
	dragonfury : 
	{
		name : "Dragon Fury",
		description : "{0} uses Dragon Fury!",
		subMenu : "Skill",
		mpCost : 300,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "spear",
		effectSprite: sDraconianFury,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_DraconianFury,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(900, 1800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 1.0;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for true damage weakness
            }
			
			// Check if the target has resistance to true damage
                if (array_contains(_targets[i].resistances, "True damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs true damage (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	DarkArrow : 
	{
		name : "Dark Arrow",
		description : "{0} uses Dark Arrow!",
		subMenu : "Skill",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sDarkArrow,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_DarkArrow,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.6;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to dark
            if (array_contains(_targets[i].weaknesses, "Dark"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for dark weakness
            }
			
			// Check if the target has resistance to dark
                if (array_contains(_targets[i].resistances, "Dark"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs dark (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Dark"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Dark"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Dark");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	VoidPiercer : 
	{
		name : "Void Piercer",
		description : "{0} uses Void Piercer!",
		subMenu : "Skill",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sVoidPiercer,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_VoidPiercer,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to dark
            if (array_contains(_targets[i].weaknesses, "Dark"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for dark weakness
            }
			
			// Check if the target has resistance to dark
                if (array_contains(_targets[i].resistances, "Dark"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs dark (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Dark"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Dark"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Dark");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	AimShot : 
	{
		name : "Aim Shot",
		description : "{0} uses Aim Shot!",
		subMenu : -1,
		mpCost : 150,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation : "attack",
		effectSprite: sRainShot,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_RainShot,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(200, 650);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to physical
            if (array_contains(_targets[i].weaknesses, "Heavy damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for physical weakness
            }
			
			// Check if the target has resistance to physical
                if (array_contains(_targets[i].resistances, "Heavy damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs physical (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Heavy damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Heavy damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Heavy damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	CycloneShot : 
	{
		name : "Cyclone Shot",
		description : "{0} uses Cyclone Shot!",
		subMenu : "Skill",
		mpCost : 250,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sCycloneShot,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Wind,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 1050);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.9;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to wind
            if (array_contains(_targets[i].weaknesses, "Wind"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for wind weakness
            }
			
			// Check if the target has resistance to wind
                if (array_contains(_targets[i].resistances, "Wind"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs wind (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Wind"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Wind"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Wind");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	SpectralRain : 
	{
		name : "Spectral Rain",
		description : "{0} uses Spectral Rain!",
		subMenu : "Skill",
		mpCost : 320,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation : "attack",
		effectSprite: sSpectralRain,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_SpectralRain,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(950, 2150);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 1.0;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for wind weakness
            }
			
			// Check if the target has resistance to true damage
                if (array_contains(_targets[i].resistances, "True damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs true damage (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	flamesword : 
	{
		name : "Flame Sword",
		description : "{0} uses Flame Sword!",
		subMenu : "Skill",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sFlameSword,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Sword,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(50, 300);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				 // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for fire weakness
            }
			
			// Check if the target has resistance to ice
                if (array_contains(_targets[i].resistances, "Fire"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs ice (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Fire"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Fire"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	icesword: 
{
    name: "Ice Sword",
    description: "{0} uses Ice Sword!",
    subMenu: "Skill",
    mpCost: 200,
    targetRequired: true,
    targetEnemyByDefault: true,
    targetAll: MODE.VARIES,
    userAnimation: "attack",
    effectSprite: sIceSword,
    effectOnTarget: MODE.ALWAYS,
    effectSound: snd_SwordIce,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _damage = irandom_range(150, 300);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;

            // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for ice weakness
            }

           // Check if the target has resistance to ice
                if (array_contains(_targets[i].resistances, "Ice"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs ice (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Ice"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Ice"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
            if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);
            BattleChangeHP(_targets[i], -_damage,0,"Ice");
        }

        BattleChangeMP(_user, -mpCost);
    }
},
	Stormstrike : 
	{
		name : "Stormstrike",
		description : "{0} uses Stormstrike!",
		subMenu : "Skill",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sStormstrike,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Stormstrike,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(500, 800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				
				 // Check if the target has a weakness to lightning
            if (array_contains(_targets[i].weaknesses, "Electric"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for lightning weakness
            }
			
			// Check if the target has resistance to lightning
                if (array_contains(_targets[i].resistances, "Electric"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs lightning (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Electric"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Electric"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Electric");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	excalibur : 
	{
		name : "Excalibur",
		description : "{0} uses Excalibur!",
		subMenu : "Skill",
		mpCost : 320,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sExcalibur,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Excalibur,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(700, 1200);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 0.8;  // Adjust scaling factor as needed
            _damage += strengthScale;
				 // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for true damage weakness
            }
			// Check if the target has resistance to true damage
                if (array_contains(_targets[i].resistances, "True damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs true damage (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	Vslash : 
	{
		name : "V Slash",
		description : "{0} uses V Slash!",
		subMenu : "Skill",
		mpCost : 400,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sVSlash,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_VSlash,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(1000, 2200);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 1.0;  // Adjust scaling factor as needed
            _damage += strengthScale;
				 // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for true damage weakness
            }
			
			// Check if the target has resistance to true damage
                if (array_contains(_targets[i].resistances, "True damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs true damage (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	
	VorpalStrike : 
	{
		name : "Vorpal Strike",
		description : "{0} uses Vorpal Strike!",
		subMenu : "Skill",
		mpCost : 400,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation : "attack",
		effectSprite: sVorpalStrike,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_VorpalStrike,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(1500, 2600);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 1.0;  // Adjust scaling factor as needed
            _damage += strengthScale;
				 // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for true damage weakness
            }
			
			// Check if the target has resistance to true damage
                if (array_contains(_targets[i].resistances, "True damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs true damage (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}
	},
	NebulaStrike : 
	{
		name : "Nebula Strike",
		description : "{0} uses Nebula Strike!",
		subMenu : "Skill",
		mpCost : 350,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.ALWAYS,
		userAnimation : "jump",
		effectSprite: sNebulaStrike,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_NebulaStrike,
		func : function(_user, _targets)
		{
			 // Hide Milan when using the skill
        _user.visible = false;
		
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(600, 1800);

            // Add scaling based on strength stat
            var strengthScale = _user.strength * 1.0;  // Adjust scaling factor as needed
            _damage += strengthScale;
				 // Check if the target has a weakness to physical
            if (array_contains(_targets[i].weaknesses, "Heavy damage"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for true damage weakness
            }
			
			// Check if the target has resistance to physical
                if (array_contains(_targets[i].resistances, "Heavy damage"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs physical (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Heavy damage"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Heavy damage"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Heavy damage");
			}
			BattleChangeMP(_user, -mpCost)
			  with (_user)
            {
                visible = true;  // Reappear after skill
                sprite_index = sprites.idle;  // Reset to idle sprite
                image_index = 0;  // Reset frame
			}
		}
	},
	defend : 
	{
		name : "Defend",
		description : "{0} assumes a defensive stance!",
		subMenu : -1,
		targetRequired: false,
		func : function(_user, _target)
		{
			_user.defending = true;
		}		
	}
	,
escape : 
{
    name : "Escape",
    description : "",
    subMenu : -1,
    targetRequired: false,
    func : function(_user, _target)
    {
        // List of enemies from which escaping is not allowed
        var noEscapeEnemies = ["Gigatoa", "Evil Wall", "Sephiroth", "Leviathan", "Bahamut", "Mimic",
							   "Cerberus", "Gilgamesh", "Rubicante", "Cagnazzo", "Milon Z", "Barbariccia",
							   "Rokor","Deity III", "Deity II", "Deity I", "The Exarch"];
        
        // Check if any enemy in the current battle is in the noEscapeEnemies list
        var canEscape = true;
        for (var i = 0; i < array_length(oBattle.enemyUnits); i++)
        {
            var enemy = oBattle.enemyUnits[i];
            if (array_contains(noEscapeEnemies, enemy.name))
            {
                canEscape = false;
                oBattle.battleText = "Can't escape from this enemy!";
                oBattle.escaped = false;
                return; // Exit the function as escape is not allowed
            }
        }

        // If escaping is allowed, proceed with the regular escape logic
        if (random(1) < 0.6) //success
        {
            oBattle.escaped = true;
            oBattle.battleText = "Successfully escaped!";
			audio_play_sound(snd_Run,1,false);
        }
        else //fail
        {
            oBattle.battleText = "Failed to escape!";
        }
    }
},
	// for enemy attack
	ClawSlash :
	{
		name : "Attack",
		description : "{0} attacks {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackSlash,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_ClawAttack,
		func : function(_user, _targets)
		{			
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 100 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
		}		
	}
	,
	EnemySmash : 
	{
		name : "Attack",
		description : "{0} uses smash to {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackBonk,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 200 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
	
	//boss attack
	BossSmash : 
	{
		name : "Attack",
		description : "{0} uses smash to {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackBonk,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 300 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
		
		BossAttack : 
	{
		name : "Attack",
		description : "{0} attacks {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackBonk,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 60 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
	SephSlash : 
	{
		name : "Attack",
		description : "{0} slashes {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sSephEffect,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_SephSlash,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 700 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
	SephSlashAll : 
	{
		name : "Attack",
		description : "{0} slashes all party members!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sSephEffect,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_SephSlash,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1000 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
	SephSlashAllv2 : 
	{
		name : "SephSlash",
		description : "{0} slashes all party members!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: Sephirothv2Attack,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_SephSlashv2,
		func : function(_user, _targets)
		{
			// Hide Sephiroth when using the skill
			 _user.visible = false;
		
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1000 + ceil(_user.strength + random_range(-_user.strength * 0.25, _user.strength * 0.25));
				BattleChangeHP(_targets[i], -_damage);
				
				 with (_user)
			 {
                visible = true;  // Reappear after jump
                sprite_index = sprites.idle;  // Reset to idle sprite
                image_index = 0;  // Reset frame
			}		
		}
	}
},
	tonberryAttack : 
	{
		name : "Attack",
		description : "{0} attacks {1}!",
		subMenu : -1,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.NEVER,
		userAnimation : "attack",
		effectSprite: sAttackBonk,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Attack,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = irandom_range(9999, 9999);
				BattleChangeHP(_targets[i], -_damage);
			}		
		}
	},
	//player magic skill
	fire : 
	{
		name : "Fire",
		description : "{0} casts Fire!",
		subMenu : "Magic",
		mpCost : 56,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetRequired: true,
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackFire,
		effectSpriteNoTarget: sAttackFire,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Fire,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 
            var _damage = irandom_range(300, 450);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.4;  // Adjust scaling factor as needed
            _damage += magicScale;
				// Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	fira : 
	{
		name : "Fira",
		description : "{0} casts Fira!",
		subMenu : "Magic",
		mpCost : 102,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetRequired: true,
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackFira,
		effectSpriteNoTarget: sAttackFira,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Fira,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				
			 var _damage = irandom_range(500, 600);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.6;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	FireBall:
	{
		name: "Fireball",
		description : "{0} casts Fireball!",
		subMenu : "Magic",
		mpCost : 160,
		mpCost : 160,
		targetRequired: true,
		targetEnemyByDefault: true,
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackFireBall,
		effectSpriteNoTarget: sAttackFireBall,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Fireball,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 
            var _damage = irandom_range(600, 750);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.7;  // Adjust scaling factor as needed
            _damage += magicScale;
				// Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	firaga: 
{
    name: "Firaga",
    description: "{0} casts Firaga!",
    subMenu: "Magic",
    mpCost: 204,
    targetEnemyByDefault: true, //0: party/self, 1: enemy
    targetRequired: true,
    targetAll: MODE.VARIES,
    userAnimation: "cast",
    effectSprite: sAttackFiraga,
    effectSpriteNoTarget: sAttackFiraga,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Firaga,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _damage = irandom_range(750, 850);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
			
            if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);

            // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
        BattleChangeMP(_user, -mpCost);
    }
},

FireVortex: 
{
    name: "Fire Vortex",
    description: "{0} casts Fire Vortex!",
    subMenu: "Magic",
    mpCost: 200,
    targetEnemyByDefault: true, //0: party/self, 1: enemy
    targetRequired: true,
    targetAll: MODE.VARIES,
    userAnimation: "cast",
    effectSprite: sAttackFireVortex,
    effectSpriteNoTarget: sAttackFireVortex,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_FireVortex,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _damage = irandom_range(1050, 1420);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
			
            if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);

            // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
        BattleChangeMP(_user, -mpCost);
    }
},
	blazing: 
{
    name: "Blazing",
    description: "{0} casts Blazing!",
    subMenu: "Magic",
    mpCost: 300,
    targetEnemyByDefault: true, //0: party/self, 1: enemy
    targetRequired: true,
    targetAll: MODE.VARIES,
    userAnimation: "cast",
    effectSprite: sAttackBlazing,
    effectSpriteNoTarget: sAttackBlazing,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Blazing,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _damage = irandom_range(1000, 1350);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
			
            if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);

           // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
        BattleChangeMP(_user, -mpCost);
    }
},
Assess:
{
	name: "Assess",
    description: "{0} uses Assess!",
    subMenu: "Magic",
    mpCost: 100,
    targetEnemyByDefault: true, 
    targetRequired: true,
    targetAll: MODE.NEVER, // Only 1 target at a time
    userAnimation: "cast",
    effectSprite: sAssess, 
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Assess,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _target = _targets[i];
            
            // Store assessed info to be drawn in oBattle
            global.assessInfo = {
               name: _target.name,
			    hp: _target.hp,
			    hpMax: _target.hpMax,
			    weaknesses: array_filter(_target.weaknesses, function(val) { return val != "" && val != " "; }), 
			    absorbs: array_filter(_target.absorbs, function(val) { return val != "" && val != " "; }), 
			    resistances: array_filter(_target.resistances, function(val) { return val != "" && val != " "; }), 
			    sprite: _target.sprite_index
            };
			 global.assessViewing = true;  
        }
        BattleChangeMP(_user, -mpCost);
    }
},
Assess2:
{
	name: "Assess",
    description: "{0} uses Assess!",
    subMenu: "Skill",
    mpCost: 100,
    targetEnemyByDefault: true,
    targetRequired: true,
    targetAll: MODE.NEVER, // Only 1 target at a time
    userAnimation: "cast",
    effectSprite: sAssess, // Custom animation if needed
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Assess,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _target = _targets[i];
            
            // Store assessed info to be drawn in oBattle
            global.assessInfo = {
               name: _target.name,
			    hp: _target.hp,
			    hpMax: _target.hpMax,
			    weaknesses: array_filter(_target.weaknesses, function(val) { return val != "" && val != " "; }), 
			    absorbs: array_filter(_target.absorbs, function(val) { return val != "" && val != " "; }), 
			    resistances: array_filter(_target.resistances, function(val) { return val != "" && val != " "; }), 
			    sprite: _target.sprite_index
            };
			 global.assessViewing = true;  
        }
        BattleChangeMP(_user, -mpCost);
    }
},
Assess3:
{
	name: "Assess",
    description: "{0} uses Assess!",
    subMenu: "Black Magic",
    mpCost: 100,
    targetEnemyByDefault: true,
    targetRequired: true,
    targetAll: MODE.NEVER, // Only 1 target at a time
    userAnimation: "cast",
    effectSprite: sAssess, // Custom animation if needed
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Assess,
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _target = _targets[i];
            
            // Store assessed info to be drawn in oBattle
            global.assessInfo = {
               name: _target.name,
			    hp: _target.hp,
			    hpMax: _target.hpMax,
			    weaknesses: array_filter(_target.weaknesses, function(val) { return val != "" && val != " "; }), 
			    absorbs: array_filter(_target.absorbs, function(val) { return val != "" && val != " "; }), 
			    resistances: array_filter(_target.resistances, function(val) { return val != "" && val != " "; }), 
			    sprite: _target.sprite_index
            };
			 global.assessViewing = true;  
        }
        BattleChangeMP(_user, -mpCost);
    }
},
	HolyStrike: 
	{
	    name: "Holy Strike",
	    description: "{0} casts Holy Strike!",
	    subMenu: "Magic",
	    mpCost: 320,
	    targetEnemyByDefault: true, //0: party/self, 1: enemy
	    targetRequired: true,
	    targetAll: MODE.VARIES,
	    userAnimation: "cast",
	    effectSprite: sAttackHolyStrike,
	    effectSpriteNoTarget: sAttackHolyStrike,
	    effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Holy,
	    func: function(_user, _targets)
	    {
	        for (var i = 0; i < array_length(_targets); i++)
	        {
	            var _damage = irandom_range(600, 1550);

	            // Add scaling based on magic stat
	            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
	            _damage += magicScale;
			
	            if (array_length(_targets) > 1) _damage = ceil(_damage * 0.75);

	           // Check if the target has a weakness to true damage
	            if (array_contains(_targets[i].weaknesses, "True damage"))
	            {
	                _damage = ceil(_damage * 2.5); 
	            }
			
				// Check if the target has resistance to true damage
	            if (array_contains(_targets[i].resistances, "True damage"))
	            {
	                _damage = ceil(_damage * 0.5); // Reduce damage 
	            }
				 // Check if the target absorbs fire (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "True damage"))
	            {
	                var _heal = ceil(_damage); 
	                BattleChangeHP(_targets[i], _heal,0,"True damage"); 
                
              
	                continue; 
	            }
					if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
					BattleChangeHP(_targets[i], -_damage,0,"True damage");
				}
	        BattleChangeMP(_user, -mpCost);
	    }
	},
	ice : 
	{
		name : "Ice",
		description : "{0} casts Ice!",
		subMenu : "Magic",
		mpCost : 32,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackIce,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ice,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				 var _damage = irandom_range(300, 450);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.4;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for ice weakness
            }
			
			// Check if the target has resistance to ice
            if (array_contains(_targets[i].resistances, "Ice"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs ice (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Ice"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Ice");
                
      
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Ice");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	ice2 : 
	{
		name : "Ice 2",
		description : "{0} casts Ice 2!",
		subMenu : "Magic",
		mpCost : 65,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackIce2,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ice2,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(500, 650);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.6;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for ice weakness
            }
			
			// Check if the target has resistance to ice
                if (array_contains(_targets[i].resistances, "Ice"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
			 // Check if the target absorbs ice (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Ice"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Ice");
                
               
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Ice");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	ice3 : 
	{
		name : "Ice 3",
		description : "{0} casts Ice 3!",
		subMenu : "Magic",
		mpCost : 105,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackIce3,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ice3,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(720, 950);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage
            }
			
			// Check if the target has resistance to ice
                if (array_contains(_targets[i].resistances, "Ice"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs ice (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Ice"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Ice"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; // Skip the rest of the loop to prevent showing the damage text
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Ice");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	IceArrow : 
	{
		name : "Ice Arrow",
		description : "{0} casts Ice Arrow!",
		subMenu : "Skill",
		mpCost : 250,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "attack",
		effectSprite: sIceArrow,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_IceArrow,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(350, 600);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage
            }
			
			// Check if the target has resistance to ice
                if (array_contains(_targets[i].resistances, "Ice"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs ice (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Ice"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Ice"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; // Skip the rest of the loop to prevent showing the damage text
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Ice");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	meteor :
	{
		name : "Meteor",
		description : "{0} casts Meteor!",
		subMenu : "Black Magic",
		mpCost : 260,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackMeteor,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Meteor,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				
			 var _damage = irandom_range(800, 1350);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
				  // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	EarthQuake :
	{
		name : "Earthquake",
		description : "{0} casts Earthquake!",
		subMenu : "Black Magic",
		mpCost : 260,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackEarthQuake,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_EarthQuake,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(620, 950);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
				  // Check if the target has a weakness to physical
            if (array_contains(_targets[i].weaknesses, "Heavy damage"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to physical
            if (array_contains(_targets[i].resistances, "Heavy damage"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs physical (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Heavy damage"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Heavy damage");
                
              
                continue; 
            }
				BattleChangeHP(_targets[i], -_damage,0,"Heavy damage");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	lightning :
	{
		name : "Lightning",
		description : "{0} casts Lightning!",
		subMenu : "Black Magic",
		mpCost : 170,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackLightning,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Lightning,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(420, 850);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
				  // Check if the target has a weakness to lightning
            if (array_contains(_targets[i].weaknesses, "Electric"))
            {
                _damage = ceil(_damage * 2.5); // Increase damage by 50% for fire weakness
            }
			
			// Check if the target has resistance to lightning
                if (array_contains(_targets[i].resistances, "Electric"))
                {
                    _damage = ceil(_damage * 0.5); // Reduce damage 
                }
				
				 // Check if the target absorbs lightning (healing instead of damage)
	            if (array_contains(_targets[i].absorbs, "Electric"))
	            {
	                var _heal = ceil(_damage); // Heal for the same amount of damage
	                BattleChangeHP(_targets[i], _heal,0,"Electric"); // Heal the enemy
                
	                // Skip applying damage text for healing
	                continue; 
	            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				
				BattleChangeHP(_targets[i], -_damage,0,"Electric");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	tornado :
	{
		name : "Tornado",
		description : "{0} casts Tornado!",
		subMenu : "Black Magic",
		mpCost : 150,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackTornado,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Tornado,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(220, 750);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
				// Check if the target has a weakness to wind
            if (array_contains(_targets[i].weaknesses, "Wind"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to wind
            if (array_contains(_targets[i].resistances, "Wind"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs wind (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Wind"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Wind"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Wind");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	WindCutter :
	{
		name : "Wind Cutter",
		description : "{0} casts Wind Cutter",
		subMenu : "Black Magic",
		mpCost : 200,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sWindCutter,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_SephSlash,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(500, 600);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
				// Check if the target has a weakness to wind
            if (array_contains(_targets[i].weaknesses, "Wind"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to wind
            if (array_contains(_targets[i].resistances, "Wind"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs wind (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Wind"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Wind"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Wind");
			}
			BattleChangeMP(_user, -mpCost)
		}			
	},
	MysticFlare :
	{
		name : "Mystic Flare",
		description : "{0} casts Mystic Flare!",
		subMenu : "Black Magic",
		mpCost : 330,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sMysticFlare,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_MysticFlare,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(820, 1850);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
				  // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to true damage
            if (array_contains(_targets[i].resistances, "True damage"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs true damage (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "True damage"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"True damage");
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	shiva :
	{
		name : "Shiva",
		description : "{0} summons Shiva!",
		subMenu : "Summon",
		mpCost : 320,
		targetRequired: true,
		targetEnemyByDefault: true, //0 or false: party/self, 1 or true: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackShiva,
		showSingleEffectSprite: true,
		effectSound: snd_Shiva,
		effectOnTarget: MODE.ALWAYS,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(1020, 1450);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
				 // Check if the target has a weakness to ice
            if (array_contains(_targets[i].weaknesses, "Ice"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to ice
            if (array_contains(_targets[i].resistances, "Ice"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs ice (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Ice"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Ice"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Ice");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	bahamut:
    {
        name: "Bahamut",
        description: "{0} summons Bahamut!",
        subMenu: "Summon",
        mpCost: 400,
        targetRequired: true,
        targetEnemyByDefault: true, //0: party/self, 1: enemy
        targetAll: MODE.ALWAYS,
        userAnimation: "cast",
		showSingleEffectSprite: true,
        effectSprite: sAttackBahamut,
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_Bahamut,
        func: function (_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
            var _damage = irandom_range(1520, 3050);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            _damage += magicScale;
              // Check if the target has a weakness to true damage
            if (array_contains(_targets[i].weaknesses, "True damage"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to true damage
            if (array_contains(_targets[i].resistances, "True damage"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs true damage (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "True damage"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"True damage"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"True damage");
			}
            BattleChangeMP(_user, -mpCost);
        }
    },
	leviathan:
    {
        name: "Leviathan",
        description: "{0} summons Leviathan!",
        subMenu: "Summon",
        mpCost: 400,
        targetRequired: true,
        targetEnemyByDefault: true, //0: party/self, 1: enemy
        targetAll: MODE.ALWAYS,
        userAnimation: "cast",
		showSingleEffectSprite: true,
        effectSprite: sAttackLeviathan,
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_Tsunami,
        func: function (_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
               var _damage = irandom_range(1020, 1550);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
                // Check if the target has a weakness to water
            if (array_contains(_targets[i].weaknesses, "Water"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to water
            if (array_contains(_targets[i].resistances, "Water"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs water (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Water"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Water"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Water");
			}
            BattleChangeMP(_user, -mpCost);
        }
    },
	ifrit :
	{
		name : "Ifrit",
		description : "{0} summons Ifrit!",
		subMenu : "Summon",
		mpCost : 320,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		showSingleEffectSprite: true,
		effectSprite: sAttackIfrit,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ifrit,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			 var _damage = irandom_range(1020, 1350);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.8;  // Adjust scaling factor as needed
            _damage += magicScale;
          // Check if the target has a weakness to fire
            if (array_contains(_targets[i].weaknesses, "Fire"))
            {
                _damage = ceil(_damage * 2.5); 
            }
			
			// Check if the target has resistance to fire
            if (array_contains(_targets[i].resistances, "Fire"))
            {
                _damage = ceil(_damage * 0.5); // Reduce damage 
            }
			 // Check if the target absorbs fire (healing instead of damage)
            if (array_contains(_targets[i].absorbs, "Fire"))
            {
                var _heal = ceil(_damage); 
                BattleChangeHP(_targets[i], _heal,0,"Fire"); 
                
              
                continue; 
            }
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage,0,"Fire");
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	cure : 
	{
		name: "Heal",
    description: "{0} casts Heal!",
    subMenu: "White Magic",
    mpCost: 100,
    targetRequired: true,
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.VARIES,
    effectSprite: sAttackHeal,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    userAnimation: "cast",
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var target = _targets[i];
            
            // Check if target is valid
            if (!target) {
                continue; // Skip invalid targets
            }

            // Retrieve HP values
            var currentHP = target.hp;
            var maxHP = target.hpMax; // Use the hpMax property for maximum HP
            
            // Ensure both values are valid
            if (maxHP <= 0) {
                continue; // Avoid division by zero
            }

            var hpPercentage = (currentHP / maxHP) * 100;

            // Base heal amount (100 to 1020)
            var baseHeal = irandom_range(100, 1020);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.4;  // Adjust scaling factor as needed
            baseHeal += magicScale;

            if (array_length(_targets) > 1) {
                baseHeal = ceil(baseHeal * 0.75);
            }

            // Apply healing using BattleChangeHP
            BattleChangeHP(target, baseHeal);
        }
        BattleChangeMP(_user, -mpCost);
    }	
},
	cura : 
	{
		name: "Heal 2",
    description: "{0} casts Heal 2!",
    subMenu: "White Magic",
    mpCost: 210,
    targetRequired: true,
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.VARIES,
    effectSprite: sAttackHeal,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    userAnimation: "cast",
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var target = _targets[i];
            
            // Check if target is valid
            if (!target) {
                continue; // Skip invalid targets
            }

            // Retrieve HP values
            var currentHP = target.hp;
            var maxHP = target.hpMax; // Use the hpMax property for maximum HP
            
            // Ensure both values are valid
            if (maxHP <= 0) {
                continue; // Avoid division by zero
            }

            var hpPercentage = (currentHP / maxHP) * 100;

            // Base heal amount (600 to 800)
            var baseHeal = irandom_range(310, 1320);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 0.6;  // Adjust scaling factor as needed
            baseHeal += magicScale;

            if (array_length(_targets) > 1) {
                baseHeal = ceil(baseHeal * 0.75);
            }

            // Apply healing using BattleChangeHP
            BattleChangeHP(target, baseHeal);
        }
        BattleChangeMP(_user, -mpCost);
    }	
},
curaga : 
{
     name: "Cure",
    description: "{0} casts Cure!",
    subMenu: "White Magic",
    mpCost: 320,
    targetRequired: true,
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.VARIES,
    effectSprite: sAttackHeal,
    effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    userAnimation: "cast",
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            var target = _targets[i];
            
            // Check if target is valid
            if (!target) {
                continue; // Skip invalid targets
            }

            // Retrieve HP values
            var currentHP = target.hp;
            var maxHP = target.hpMax; // Use the hpMax property for maximum HP
            
            // Ensure both values are valid
            if (maxHP <= 0) {
                continue; // Avoid division by zero
            }

            var hpPercentage = (currentHP / maxHP) * 100;

            // Base heal amount 
            var baseHeal = irandom_range(100, 1000);

            // Add scaling based on magic stat
            var magicScale = _user.magic * 1.0;  // Adjust scaling factor as needed
            baseHeal += magicScale;

            if (array_length(_targets) > 1) {
                baseHeal = ceil(baseHeal * 0.75);
            }

            // Apply healing using BattleChangeHP
            BattleChangeHP(target, baseHeal);
        }
        BattleChangeMP(_user, -mpCost);
    }	
},
	resurrect : 
	{
		name : "Resurrect",
		description : "{0} casts Resurrect!",
		subMenu : "White Magic",
		mpCost : 156,
		targetRequired: true,
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		effectSprite: sResurrect,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Resurrect,
		userAnimation : "cast",
		func : function(_user, _targets)
		{
			 var target = _targets[0];

            if (target.hp <= 0) // Only apply if the target is actually dead
            {
                var _heal = target.hpMax / 2; // Revive with 50% HP
                BattleChangeHP(target, _heal, 1); // Heal the target
                
                // Clear all status effects upon revival
                target.paralyzed = false;
                target.paralyzeTurns = 0;

			BattleChangeMP(_user, -mpCost);
		}					
	}
},

		//enemy magic skill
		Enemyfire : 
	{
		name : "Fire",
		description : "{0} casts Fire to {1}!",
		subMenu : "Magic",
		mpCost : 4,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetRequired: true,
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackFira,
		effectSpriteNoTarget: sAttackFire,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Fira,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 200 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	}
	,
	EnemyParalyze :
	{
	name: "Paralyze",
    description: "{0} uses Paralyze on {1}!",
    subMenu: "Black Magic",
    mpCost: 100,
    targetRequired: true,
    targetEnemyByDefault: true, // Targets enemies by default
    userAnimation: "cast",
    effectSprite: sEnemyParalyze, 
    effectOnTarget: MODE.ALWAYS,
    effectSound: snd_Paralyze, 
    func: function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++)
        {
            
            _targets[i].paralyzed = true;
            _targets[i].paralyzeTurns = 2; // paralyzed for 2 turns
        }
        
        BattleChangeMP(_user, -mpCost);
    }
},
	Enemyice : 
	{
		name : "Ice",
		description : "{0} casts Ice to {1}!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackIce3,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ice3,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 200 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				if (array_length(_targets) > 1) _damage = ceil(_damage*0.75);
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
		
	},
	//Boss Magic Skill
	BossAblaze : 
	{
		name : "Ablaze",
		description : "{0} casts Ablaze to {1}!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sEnemyAblaze,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ablaze,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 400 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	BossAblazeAll : 
	{
		name : "Ablaze",
		description : "{0} casts Ablaze to all members!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sEnemyAblaze,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Ablaze,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 400 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	BossVortex : 
	{
		name : "Fire Vortex",
		description : "{0} casts Fire Vortex to {1}!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackFireVortex,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_FireVortex,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 700 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	BossVortexAll : 
	{
		name : "Fire Vortex All",
		description : "{0} casts Fire Vortex to all members!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sAttackFireVortex,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_FireVortex,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 700 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	RagnarokStrike : 
	{
		name : "Ragnarok Strike",
		description : "{0} casts Ragnarok Strike!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sRagnarokStrike,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_RagnarokStrike,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1000 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	EclipseSurgeAll : 
	{
		name : "Eclipse Surge",
		description : "{0} casts Eclipse Surge!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sEclipseSurge,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_EclipseSurge,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1200 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	EternalFrost : 
	{
		name : "Eternal Frost",
		description : "{0} casts Eternal Frost!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sEternalFrost,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_EternalFrost,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1200 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	DivineThunder : 
	{
		name : "Divine Thunder",
		description : "{0} casts Divine Thunder!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sDivineThunder,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_DivineThunder,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	JudgmentRay : 
	{
		name : "Judgment Ray",
		description : "{0} casts Judgment Ray!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sJudgmentRay,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_JudgmentRay,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1700 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	whirlpool:
    {
        name: "Whirlpool",
        description: "{0} casts Whirlpool to {1}!",
        subMenu: "Magic",
        mpCost: 400,
        targetRequired: true,
        targetEnemyByDefault: true, //0: party/self, 1: enemy
        targetAll: MODE.NEVER,
        userAnimation: "cast",
        effectSprite: sWhirlPool,
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_WhirlPool,
        func: function (_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
                var _damage = 100 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
                
                BattleChangeHP(_targets[i], -_damage);
            }
            BattleChangeMP(_user, -mpCost);
        }
    },
	whirlpoolAll:
    {
        name: "Whirlpool",
        description: "{0} casts Whirlpool to all members!",
        subMenu: "Magic",
        mpCost: 400,
        targetRequired: true,
        targetEnemyByDefault: true, //0: party/self, 1: enemy
        targetAll: MODE.ALWAYS,
        userAnimation: "cast",
		showSingleEffectSprite: true,
        effectSprite: sWhirlpoolBig,
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_WhirlPool,
        func: function (_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
                var _damage = 500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
                
                BattleChangeHP(_targets[i], -_damage);
            }
            BattleChangeMP(_user, -mpCost);
        }
    },
	 MegaFlare:
    {
        name: "Mega Flare",
		description: " {2} ",
        subMenu: "Magic",
        mpCost: 400,
        targetRequired: true,
        targetEnemyByDefault: true,  // 0: party/self, 1: enemy
        targetAll: MODE.ALWAYS,
        userAnimation: "cast",
        showSingleEffectSprite: true,
        func: function (_user, _targets) 
        {
            // Check if Bahamut is still charging the Mega Flare
            if (global.Countdown > 0)
            {
                global.Countdown--;  // Reduce the countdown by 1
                
                // Update the battle text to show the charging phase
                battleText = string_ext(" {1} ", [_user.name, string(global.Countdown)]);
            }
            else
            {				
                // Create the effect sprite at the center of the targets
                var effectSprite = sAttackBahamut;  // Effect sprite for Mega Flare
                var effectSound = snd_Bahamut;      // Sound effect for Mega Flare

                // Calculate the central position for the effect sprite (average of all targets)
                var centralX = 0, centralY = 0;
                for (var i = 0; i < array_length(_targets); i++)
                {
                    centralX += _targets[i].x;
                    centralY += _targets[i].y;
                }
                centralX /= array_length(_targets);
                centralY /= array_length(_targets);

                // Create the sprite effect at the center of the targets
                instance_create_depth(centralX, centralY, _targets[0].depth - 1, oBattleEffect, {sprite_index: effectSprite});

                // Play the sound effect for Mega Flare
                audio_play_sound(effectSound, 1, false);

                // Apply damage to all targets
                for (var i = 0; i < array_length(_targets); i++)
                {
                    var _damage = irandom_range(9999, 9999);
						
                    // Apply the damage to each target
                    BattleChangeHP(_targets[i], -_damage);
                }

                // Reduce the user's MP by the Mega Flare cost
                BattleChangeMP(_user, -mpCost);

                // Reset the countdown for future use of the skill
                global.Countdown = 10;
            }
        }
    },
	BossBeam : 
	{
		name : "Beam",
		description : "{0} casts Beam!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sEnemyBeam,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Beam,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 1000 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
		
	},
	BossMagma : 
	{
		name : "Magma",
		description : "{0} casts Magma to {1}!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sMagma,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Magma,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 700 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}				
	},
	BossLifeDrainer : 
    {
        name : "Life Drainer",
        description : "{0} uses Life Drainer!",
        subMenu : "Magic",
        mpCost : 6,
        targetRequired: true,
        targetEnemyByDefault: true,
        targetAll: MODE.ALWAYS,
        userAnimation : "cast",
        effectSprite: sAttackLifeDrainer,  
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_LifeDrainer,  
        func : function(_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
                BattleChangeHP(_targets[i], -_targets[i].hp);  // Instant Kill
            }
            BattleChangeMP(_user, -mpCost);  // Deduct MP cost
        }
    },
	HeartlessAngel : 
    {
        name : "Heartless Angel",
        description : "{0} uses Heartless Angel!",
        subMenu : "Magic",
        mpCost : 6,
        targetRequired: true,
        targetEnemyByDefault: true,
        targetAll: MODE.ALWAYS,
        userAnimation : "cast",
        effectSprite: sHeartlessAngel, 
        effectOnTarget: MODE.ALWAYS,
        effectSound: snd_HeartlessAngel, 
        func : function(_user, _targets)
        {
            for (var i = 0; i < array_length(_targets); i++)
            {
                BattleChangeHP(_targets[i], 1 -_targets[i].hp);  // Instant 1 HP
            }
            BattleChangeMP(_user, -mpCost);  // Deduct MP cost
        }
    },
	BossMagmaAll : 
	{
		name : "Magma",
		description : "{0} casts Magma to all members!",
		subMenu : "Magic",
		mpCost : 4,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		effectSprite: sMagma,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Magma,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
				var _damage = 700 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}				
	},
	LevTsunami :
	{
		name : "Tsunami",
		description : "{0} casts Tsunami!",
		subMenu : "Black Magic",
		mpCost : 170,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		showSingleEffectSprite: true,
		effectSprite: sTsunami,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Tsunami,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 900 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
		
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	BossEarthQuake :
	{
		name : "Earthquake",
		description : "{0} casts Earthquake!",
		subMenu : "Black Magic",
		mpCost : 170,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		userAnimation : "cast",
		showSingleEffectSprite: true,
		effectSprite: sAttackEarthQuake,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_EarthQuake,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 900 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
		
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	BossMeteor :
	{
		name : "Meteor",
		description : "{0} casts Meteor!",
		subMenu : "Black Magic",
		mpCost : 260,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		userAnimation : "cast",
		effectSprite: sSephMeteor,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Meteor,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 1000 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephLightning :
	{
		name : "Electric",
		description : "{0} casts Lightning to {1}!",
		subMenu : "Black Magic",
		mpCost : 170,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackLightning,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Lightning,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
		
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephLightningAll :
	{
		name : "Electric",
		description : "{0} casts Lightning to all members!",
		subMenu : "Black Magic",
		mpCost : 170,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackLightning,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Lightning,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
		
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephTornado :
	{
		name : "Tornado",
		description : "{0} casts Tornado to {1}!",
		subMenu : "Black Magic",
		mpCost : 150,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackTornado,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Tornado,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 200 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));

				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephTornadoAll :
	{
		name : "Tornado",
		description : "{0} casts Tornado to all members",
		subMenu : "Black Magic",
		mpCost : 150,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.VARIES,
		userAnimation : "cast",
		effectSprite: sAttackTornado,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Tornado,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));

				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephMeteor :
	{
		name : "Meteor",
		description : "{0} casts Meteor!",
		subMenu : "Black Magic",
		mpCost : 260,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		userAnimation : "cast",
		effectSprite: sSephMeteor,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Meteor,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 1500 + ceil(_user.magic + random_range(-_user.magic * 0.25, _user.magic * 0.25));
				
				BattleChangeHP(_targets[i], -_damage);
			}
			BattleChangeMP(_user, -mpCost)
		}		
	},
	SephUlt :
	{
		name : "Hellfire",
		description : "{0} uses Hellfire!",
		subMenu : "Black Magic",
		mpCost : 260,
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		userAnimation : "ulti",
		effectSprite: sSephUlt_1,
		showSingleEffectSprite: true,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Hellfirev2,
		func : function(_user, _targets)
		{
			 // Hide Sephiroth when using the skill
        _user.visible = false;
        
        for (var i = 0; i < array_length(_targets); i++)
        {
            var _damage = irandom_range(3700, 4200);
            BattleChangeHP(_targets[i], -_damage);
        }
        
	        // Deduct MP cost
	        BattleChangeMP(_user, -mpCost);
		  with (_user)
            {
                visible = true;  // Reappear after jump
                sprite_index = sprites.idle;  // Reset to idle sprite
                image_index = 0;  // Reset frame
		}
    }
},
	potion : 
	{
		name : "Potion",
		description : "{0} uses a Potion!",
		userAnimation: "idle",
		subMenu : "Item",
		targetRequired: true,
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		effectSprite: sAttackHeal,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Cure,
		func : function(_user, _targets)
		{
			var _heal = 930;
			BattleChangeHP(_targets[0], _heal);
		}		
	}
	,
	ether : 
	{
		name : "Ether",
		description : "{0} uses a Ether!",
		subMenu : "Item",
		userAnimation: "idle",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
	    effectSprite: sAttackMP,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Cure,
		func : function(_user, _targets)
		{
			var _healMP = 1500;
			BattleChangeMP(_targets[0], _healMP, true);
		}		
	},
	elixir : 
	{
		name : "Elixir",
		description : "{0} uses a Elixir!",
		subMenu : "Item",
		userAnimation: "idle",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
	    effectSprite: sAttackHeal,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Cure,
		func : function(_user, _targets)
		{
			var _heal = 1500;
			BattleChangeHP(_targets[0], _heal);
			var _healMP = 1500;
			BattleChangeMP(_targets[0], _healMP, true);
		}		
	},
	revive : 
	{
		name : "Revive",
		description : "{0} uses a Revive!",
		subMenu : "Item",
		userAnimation: "idle",
		targetEnemyByDefault: false, //0: party/self, 1: enemy
		targetAll: MODE.NEVER,
		targetRequired: true,
		effectSprite: sResurrect,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Resurrect,
		func : function(_user, _targets)
		{
			// Get the target character
			var target = _targets[0];
			if (target.hp <= 0) // Only apply if the target is actually dead
            {
                var _heal = target.hpMax;
				BattleChangeHP(target, _heal - target.hp, 1);
                // Clear all status effects upon revival
                target.paralyzed = false;
                target.paralyzeTurns = 0;
		}		
	}
},
	HighPotion : 
{
    name : "H-Potion",
    description : "{0} uses a High Potion!",
    subMenu : "Item",
	userAnimation: "idle",
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.NEVER,
    targetRequired: true,
	effectSprite: sAttackHeal,
	effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    func : function(_user, _targets)
    {
        // Get the target character
        var target = _targets[0];
        
        // Restore HP to full
        var _heal = target.hpMax;
        BattleChangeHP(target, _heal - target.hp);  // Heal the difference to max

    }		
},
Remedy : 
    {
        name : "Remedy",
        description : "{0} uses a Remedy!",
        subMenu : "Item",
        userAnimation: "idle",
        targetEnemyByDefault: false, 
        targetAll: MODE.NEVER,
        targetRequired: true, 
		effectSprite: sAttackMP,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Cure,
        func : function(_user, _targets)
		{
        // Get the target character
            var target = _targets[0];
            
            // Cure the "Paralyze" status effect if the target is paralyzed
            if (target.paralyzed) 
            {
                target.paralyzed = false;     // Remove the paralyzed state
                target.paralyzeTurns = 0;     // Reset the paralyze duration
            }
        }
    },
HighElixir : 
{
    name : "H-Elixir",
    description : "{0} uses a High Elixir!",
    subMenu : "Item",
	userAnimation: "idle",
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.NEVER,
    targetRequired: true,
	effectSprite: sAttackHeal,
	effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    func : function(_user, _targets)
    {
        // Get the target character
        var target = _targets[0];
        
        // Restore HP to full
        var _heal = target.hpMax;
        BattleChangeHP(target, _heal - target.hp);  // Heal the difference to max

        // Restore MP to full
        var _healMP = target.mpMax;
        BattleChangeMP(target, _healMP - target.mp, true);  // Heal the difference to max

    }		
},
HighEther : 
{
    name : "H-Ether",
    description : "{0} uses a High Ether!",
    subMenu : "Item",
	userAnimation: "idle",
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.NEVER,
    targetRequired: true,
	effectSprite: sAttackMP,
	effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    func : function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++) {

             var _target = _targets[i];
                
             // Restore MP to full for each target
             var _healMP = _target.mpMax;
             BattleChangeMP(_target, _healMP - _target.mp, true);  // Heal the difference to max
		}
    }		
},

XEther : 
{
    name : "X-Ether",
    description : "{0} uses a X-Ether!",
    subMenu : "Item",
	userAnimation: "idle",
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.ALWAYS,
    targetRequired: true,
	effectSprite: sAttackMP,
	effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    func : function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++) {

             var _target = _targets[i];
                
             // Restore MP to full for each target
             var _healMP = _target.mpMax;
             BattleChangeMP(_target, _healMP - _target.mp, true);  // Heal the difference to max
		}
    }		
},
XPotion : 
{
    name : "X-Potion",
    description : "{0} uses a X-Potion!",
    subMenu : "Item",
	userAnimation: "idle",
    targetEnemyByDefault: false, //0: party/self, 1: enemy
    targetAll: MODE.ALWAYS,
    targetRequired: true,
	effectSprite: sAttackHeal,
	effectOnTarget: MODE.ALWAYS,
	effectSound: snd_Cure,
    func : function(_user, _targets)
    {
        for (var i = 0; i < array_length(_targets); i++) {

             var _target = _targets[i];
                
              // Restore HP to full
        var _heal = _target.hpMax;
        BattleChangeHP(_target, _heal - _target.hp);  // Heal the difference to max
		}
    }		
},
	wipeout:
	{
	name : "Wipe Out",
		description : "{0} uses a Wipe Out!",
		subMenu : "Item",
		userAnimation: "idle",
		targetRequired: true,
		targetEnemyByDefault: true, //0: party/self, 1: enemy
		targetAll: MODE.ALWAYS,
		effectOnTarget: MODE.ALWAYS,
		effectSound: snd_Cure,
		func : function(_user, _targets)
		{
			for (var i = 0; i < array_length(_targets); i++)
			{
			var _damage = 55500;
				
				BattleChangeHP(_targets[i], -_damage);
			}
			
		}		
	}
}


global.weaponLibrary = 
{
    DeathBow: 
	{
        name : "Death Bow",
		type : "Bow",
        description : "Bow that gives 1000 strength.",
        strengthBonus : 1000,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
    },
	UltimaSword:
	{
		name: "Ultima Sword",
		type: "Sword",
		description: "Gives 9999 stats.",
		strengthBonus : 9999,
        magicBonus : 9999,
        hpBonus : 9999,
        mpBonus : 9999
	},
	UltimaLance:
	{
		name: "Ultima Lance",
		type: "Spear",
		description: "Gives 9999 stats.",
		strengthBonus : 9999,
        magicBonus : 9999,
        hpBonus : 9999,
        mpBonus : 9999
	},
	UltimaStaff:
	{
		name: "Ultima Staff",
		type: "Staff",
		description: "Gives 9999 stats.",
		strengthBonus : 9999,
        magicBonus : 9999,
        hpBonus : 9999,
        mpBonus : 9999
	},
	UltimaBow:
	{
		name: "Ultima Bow",
		type: "Bow",
		description: "Gives 9999 stats.",
		strengthBonus : 9999,
        magicBonus : 9999,
        hpBonus : 9999,
        mpBonus : 9999
	},
	UltimaBook:
	{
		name: "Ultima Book",
		type: "Book",
		description: "Gives 9999 stats.",
		strengthBonus : 9999,
        magicBonus : 9999,
        hpBonus : 9999,
        mpBonus : 9999
	},
	
	EternalValor:
	{
		name: "Eternal Valor",
		type: "Sword",
		description: "A sword that gives 1600 str and hp/mp 1000",
		strengthBonus : 1600,
        magicBonus : 0,
        hpBonus : 1000,
        mpBonus : 1000
	},
	
	CrimsonHunt:
	{
		name: "Crimson Hunt",
		type: "Spear",
		description: "A spear that gives 1600 str and hp/mp 1000",
		strengthBonus : 1600,
        magicBonus : 0,
        hpBonus : 1000,
        mpBonus : 1000
	},
	
	ArcaneWhispers:
	{
		name: "Arcane Whispers",
		type: "Book",
		description: "A book that gives 1600 magic and hp/mp 1000",
		strengthBonus : 0,
        magicBonus : 1600,
        hpBonus : 1000,
        mpBonus : 1000
	},
	
	WindstriderLongbow:
	{
		name: "Windstrider",
		type: "Bow",
		description: "A bow that gives 1600 str and hp/mp 1000",
		strengthBonus : 1600,
        magicBonus : 0,
        hpBonus : 1000,
        mpBonus : 1000
	},
	
	CelestialDawn:
	{
		name: "Celestial Dawn",
		type: "Staff",
		description: "A staff that gives 1600 magic and\nhp/mp 1000",
		strengthBonus : 0,
        magicBonus : 1600,
        hpBonus : 1000,
        mpBonus : 1000
	},
	
	LongBow: 
	{
        name : "Longbow",
		type : "Bow",
        description : "Bow that gives 550 strength.",
        strengthBonus : 550,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
    },
	greatSword: 
	{
        name : "Great Sword",
		type : "Sword",
        description : "Sharp blade that gives 500 strength.",
        strengthBonus : 500,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
    },
	masamune: 
	{
        name : "Masamune",
		type : "Sword",
        description : "A symbol of mastery and honor, gives 1000\nstrength.",
        strengthBonus : 1000,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
    },
	ExSword: 
	{
        name : "Excalibur",
		type : "Sword",
        description : "Mythril blade that gives 1000000 strength.",
        strengthBonus : 1000000,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
    },
    staff: 
	{
        name : "Magic Staff",
		type : "Staff",
        description : "Mystical staff gives 100 magic.",
        strengthBonus : 0,
        magicBonus : 100,
        hpBonus : 0,
        mpBonus : 0
	},
	 Arcanist: 
	{
        name : "Arcanist",
		type : "Book",
        description : "Gives 1000 magic to the Summoner.",
        strengthBonus : 0,
        magicBonus : 1000,
        hpBonus : 0,
        mpBonus : 0
	},
	SageStaff:
	{
		name : "Sage Staff",
		type : "Staff",
		description : "Gives 750 magic to the Mage.",
        strengthBonus : 0,
        magicBonus : 750,
        hpBonus : 0,
        mpBonus : 0
	},
	lance:
	{
		name : "Lance",
		type : "Spear",
		description : "Great lance that gives 1000 strength.",
        strengthBonus : 1000,
        magicBonus : 0,
        hpBonus : 0,
        mpBonus : 0
	},
	book:
	{
		name : "Book of Gaia",
		type : "Book",
		description : "Great book that gives 100 magic.",
        strengthBonus : 0,
        magicBonus : 100,
        hpBonus : 0,
        mpBonus : 0
	}
}


//Enemy Data


function formatArray(_array) {
    if (array_length(_array) == 0) return "None"; // If array is empty, return "None"

    var result = "";
    for (var i = 0; i < array_length(_array); i++) {
        if (i > 0) result += ", "; // Add comma separator after the first item
        result += string(_array[i]);
    }

    return result;
}


//Inventory
global.inventory =
[
	[global.actionLibrary.potion, 2],
	[global.actionLibrary.revive, 2],
	[global.actionLibrary.ether, 2],

]

global.weaponInventory = 
[
	
]

function RemoveWeaponFromInventory(_weapon, _amount) {
    for (var i = 0; i < array_length(global.weaponInventory); i++) {
        if (global.weaponInventory[i][0] == _weapon) {
            global.weaponInventory[i][1] -= _amount;

            // If weapon count reaches 0, remove it from the inventory
            if (global.weaponInventory[i][1] <= 0) {
                array_delete(global.weaponInventory, i, 1);
            }
            break;
        }
    }
}

// Function to add a weapon to the inventory
function AddWeaponToInventory(weapon, quantity) {
    for (var i = 0; i < array_length(global.weaponInventory); i++) {
        if (global.weaponInventory[i][0] == weapon) {
            global.weaponInventory[i][1] += quantity;
            return;
        }
    }
    // If the weapon is not in the inventory, add it
    array_push(global.weaponInventory, [weapon, quantity]);
}	

function RemoveItemFromInventory(_item, _amount)
{
	
	for (var i = 0; i < array_length(global.inventory); i++)
	{
		if (global.inventory[i][0] == _item)
		{
			global.inventory[i][1] -= _amount;
			break;
		}
	}
}