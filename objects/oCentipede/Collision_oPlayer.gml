
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.centipede, global.enemies.centipede, global.enemies.centipede],
			),
		sBgNewDesert
	);
	audio_play_sound(snd_BattleScene,1,true);
	audio_stop_sound(snd_Opening);
	audio_stop_sound(snd_Desert);
	instance_destroy();
}