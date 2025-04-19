
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.Blazefang, global.enemies.Blazefang],
			[global.enemies.tonberry, global.enemies.Blazefang],
			[global.enemies.centipede, global.enemies.Blazefang],
			[global.enemies.Blazefang],
			),
		sBgNewDesert
	);
	audio_play_sound(snd_ExtraBossTheme,1,true);
	audio_stop_sound(snd_Opening);
	audio_stop_sound(snd_Desert);
	instance_destroy();
}