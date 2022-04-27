extends Control

var menueCamera
var label_wecker
var label_time
var label_top_wecker
var label_top_time


func _ready():
	
	label_wecker = $MediumAnker/score_Control/score_GridContainer/WeckerScore
	label_time = $MediumAnker/score_Control/score_GridContainer/GetraeumteZeitScore
	label_top_time = $MediumAnker/score_Control/score_GridContainer/topTime
	label_top_wecker = $MediumAnker/score_Control/score_GridContainer/topWecker


func gameOver(score_wecker, scoreTime, highscore_wecker, highscore_time):
	
	$MediumAnker/VBoxContainer/StartButton.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt/Other/UI/Camera/MenueCamera")
	menueCamera.set_current(true)
	
	label_wecker.text = String(score_wecker)
	label_wecker.text += "x"
	label_top_wecker.text = String(highscore_wecker)
	label_top_wecker.text += "x"
	
	label_time.text = ""
	var minutes = floor(scoreTime/60.0)
	if minutes < 10:
		label_time.text += "0"
	label_time.text += String(minutes)
	label_time.text += "."
	if (scoreTime - 60 * minutes) < 10:
		label_time.text += "0"
	label_time.text += String(scoreTime - 60 * minutes)
	
	label_top_time.text = ""
	minutes = floor(highscore_time/60.0)
	if minutes < 10:
		label_top_time.text += "0"
	label_top_time.text += String(minutes)
	label_top_time.text += "."
	if (scoreTime - 60 * minutes) < 10:
		label_top_time.text += "0"
	label_top_time.text += String(highscore_time - 60 * minutes)


func _on_RestartButton_pressed():
	
	get_tree().get_root().get_node("Spielwelt").restart()

func _on_StartButton_pressed():
	
	Settings.restart_level = -1
	get_tree().paused = false
	get_tree().change_scene("res://Spielwelt.tscn")


func _on_quit_button_pressed():
	
	get_tree().get_root().get_node("Spielwelt").close_application()
