// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_current_datetime(){
	
/// scr_get_current_datetime
// Returns the current date and time as a formatted string

var now = date_current_datetime();

var year = string(date_get_year(now));
var month = scr_string_pad(date_get_month(now), 2, "0");
var day = scr_string_pad(date_get_day(now), 2, "0");

var hour = scr_string_pad(date_get_hour(now), 2, "0");
var minute = scr_string_pad(date_get_minute(now), 2, "0");
var second = scr_string_pad(date_get_second(now), 2, "0");

// Format the date and time string
var datetime_str = month + "/" +
                   day + "/" +
                   year + " " +
                   hour + ":" +
                   minute + ":" +
                   second;

return datetime_str;

}