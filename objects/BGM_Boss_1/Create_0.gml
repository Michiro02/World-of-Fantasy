/// @description Insert description here
// You can write your code in this editor
// Example: Set the next map to BossRoom and its sound
global.nextMap = "Pyramid";
global.nextMapSound = snd_Opening;

audio_stop_sound(snd_LiberiFatali);
audio_play_sound(snd_Opening,1,true);

audio_stop_sound(snd_GigaLair);
audio_stop_sound(snd_Desert);
audio_stop_sound(snd_SephMap);
audio_stop_sound(snd_Town);
audio_stop_sound(snd_Win);
audio_stop_sound(snd_BossFinal);
audio_stop_sound(snd_Overworld);
audio_stop_sound(snd_Inn);
audio_stop_sound(snd_Leviathan);
audio_stop_sound(snd_Castle);
audio_stop_sound(snd_Tower);
audio_stop_sound(snd_Forest);

