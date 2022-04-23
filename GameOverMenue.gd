extends Control

var menueCamera
var LableWecker
var LableZeit


func _ready():
	
	LableWecker = $MediumAnker/score_Control/score_GridContainer/WeckerScore
	LableZeit = $MediumAnker/score_Control/score_GridContainer/GetraeumteZeitScore


func _gameOver(scoreWecker, scoreTime):
	
	$MediumAnker/VBoxContainer/StartButton.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt/Other/UI/Camera/MenueCamera")
	menueCamera.set_current(true)
	
	LableWecker.text = String(scoreWecker)
	LableWecker.text += "x"
	LableZeit.text = ""
	
	var minutes = floor(scoreTime/60.0)
	if minutes < 10:
		LableZeit.text += "0"
	LableZeit.text += String(minutes)
	LableZeit.text += ":"
	if (scoreTime - 60 * minutes) < 10:
		LableZeit.text += "0"
	LableZeit.text += String(scoreTime - 60 * minutes)


func _on_RestartButton_pressed():
	
	get_tree().get_root().get_node("Spielwelt").restart()

func _on_StartButton_pressed():
	
	get_tree().paused = false
	get_tree().change_scene("res://Spielwelt.tscn")


func _on_quit_button_pressed():
	
	get_tree().quit()
