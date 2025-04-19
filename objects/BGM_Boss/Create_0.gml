/// @description Insert description here
// You can write your code in this editor
// Example: Set the next map to BossRoom and its sound
global.nextMap = "Room5";
global.nextMapSound = snd_GigaLair;


audio_stop_all()
audio_play_sound(snd_GigaLair,1,true);


