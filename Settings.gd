extends Node


var scalar_mouse_look = 1.0
var scalar_gamepad_look = 1.0
var scalar_music = 1.0
var scalar_audio = 1.0

var is_fullscreen = true

var restart_level = -1

var highscore_wecker_0 : int = 0
var highscore_wecker_1 : int = 0
var highscore_wecker_2 : int = 0
var highscore_time_0 : float = 0.0
var highscore_time_1 : float = 0.0
var highscore_time_2 : float = 0.0


func get_highscore_time(scoreTime):
	
	var string_time = ""
	var minutes = floor(scoreTime/60.0)
	
	if minutes < 10:
		string_time += "0"
	string_time += String(minutes)
	string_time += "."
	if (scoreTime - 60 * minutes) < 10:
		string_time += "0"
	string_time += String(scoreTime - 60 * minutes) + " min"
	
	return string_time
