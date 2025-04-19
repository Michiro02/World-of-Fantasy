
if (escapeDelay == 0) && (!dead)
{
	NewEncounter(
		choose(
			[global.enemies.RedGiant],
			[global.enemies.RedGiant, global.enemies.RedGiant],
			[global.enemies.IronGiant, global.enemies.RedGiant],
			),
		sBgNewBoss
	);
	audio_play_sound(snd_IronGiant,1,true);
	audio_stop_sound(snd_Tower);
	instance_destroy();
}