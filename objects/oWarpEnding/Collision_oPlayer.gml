/// @description Insert description here
// You can write your code in this editor
room_goto(targetRoom);
oPlayer.x = targetX;
oPlayer.y = targetY;

var target = Void;
if (room == Void) target = RoomEnd; 
//TransitionStart(target,sqFadeOut,sqSlideInDiagonal);