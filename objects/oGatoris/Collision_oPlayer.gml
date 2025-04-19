
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.Gatoris,global.enemies.Gatoris],
			[global.enemies.Gatoris,global.enemies.bat, global.enemies.mush],
			[global.enemies.Gatoris, global.enemies.Skyhawk],
			[global.enemies.Gatoris]
			),
		sBgNewForest
	);
	audio_play_sound(snd_BattleScene,1,true);
	audio_stop_sound(snd_Forest);
	instance_destroy();
}