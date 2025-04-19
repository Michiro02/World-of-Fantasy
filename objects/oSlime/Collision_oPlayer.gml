if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.slimeG,global.enemies.slimeG,global.enemies.bat],
			[global.enemies.slimeG,global.enemies.slimeG],
			[global.enemies.slimeG,global.enemies.bat,global.enemies.bat,global.enemies.bat,global.enemies.bat],
			[global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG,global.enemies.slimeG],
			[global.enemies.slimeG,global.enemies.bat]
		), 
		sBgField
	);
	audio_play_sound(snd_BattleScene,1,true);
	audio_stop_sound(snd_Overworld);
	instance_destroy();
}