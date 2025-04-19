
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.tonberry, global.enemies.tonberry],
			[global.enemies.tonberry],
			),
		sBgNewDesert
	);
	audio_play_sound(snd_ExtraBossTheme,1,true);
	audio_stop_sound(snd_Opening);
	audio_stop_sound(snd_Desert);
	instance_destroy();
}