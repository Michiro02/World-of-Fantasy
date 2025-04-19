
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.Tuskbreaker, global.enemies.Lynxara],
			[global.enemies.Tuskbreaker, global.enemies.Blazefang],
			[global.enemies.Tuskbreaker],
			[global.enemies.Tuskbreaker],
			),
		sBgNewDesert
	);
	audio_play_sound(snd_ExtraBossTheme,1,true);
	audio_stop_sound(snd_Opening);
	audio_stop_sound(snd_Desert);
	instance_destroy();
}