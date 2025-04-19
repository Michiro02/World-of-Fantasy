// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_string_pad(){
	
/// scr_string_pad
// Pads a number `num` with `pad_char` to reach `length` characters
var num = argument0;  // Number or string to pad
var length = argument1;  // Desired length of the resulting string
var pad_char = argument2;  // Character used for padding

var str = string(num);  // Convert num to string
var pad_length = max(0, length - string_length(str));  // Calculate padding length

for (var i = 0; i < pad_length; i++) {
    str = pad_char + str;  // Add pad_char in front of str
}

return str;  // Return padded string


}