
// Example: Set the next map to BossRoom and its sound
global.nextMap = "Room7";
global.nextMapSound = snd_BossFinal;

audio_stop_all()
audio_play_sound(snd_BossFinal,1,true);
