
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.behemoth],
			[global.enemies.behemoth,global.enemies.behemoth],
			[global.enemies.behemoth,global.enemies.mush],
			[global.enemies.behemoth,global.enemies.behemoth, global.enemies.behemoth],
			[global.enemies.behemoth,global.enemies.behemoth, global.enemies.mush],
			),
		sBgNewForest
	);
	audio_play_sound(snd_ExtraBossTheme,1,true);
	audio_stop_sound(snd_Forest);
	instance_destroy();
}