
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.mush,global.enemies.mush,global.enemies.bat],
			[global.enemies.mush,global.enemies.mush],
			[global.enemies.mush,global.enemies.mush,global.enemies.mush,global.enemies.bat,global.enemies.bat],
			[global.enemies.mush,global.enemies.mush,global.enemies.mush,global.enemies.mush,global.enemies.mush],
			[global.enemies.mush,global.enemies.bat]
			),
		sBgNewForest
	);
	audio_play_sound(snd_BattleScene,1,true);
	audio_stop_sound(snd_Forest);
	instance_destroy();
}