
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.rokor],
			),
		sBgNewPyramid
	);
	audio_play_sound(snd_PyramidBoss,1,true);
	audio_stop_sound(snd_Opening);
	audio_stop_sound(snd_Desert);
	global.rokorDefeated = true;
	instance_destroy();
}