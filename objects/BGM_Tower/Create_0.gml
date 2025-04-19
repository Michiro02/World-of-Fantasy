/// @description Insert description here
// You can write your code in this editor
// Example: Set the next map to BossRoom and its sound
global.nextMap = "Tower";
global.nextMapSound = snd_Tower;

audio_stop_all()
audio_play_sound(snd_Tower,1,true);

