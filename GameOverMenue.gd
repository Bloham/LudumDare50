extends Control


var menueCamera
var LableWecker
var LableZeit


# Called when the node enters the scene tree for the first time.
func _ready():
	LableWecker = $MediumAnker/PanelContainer/GridContainer/WeckerScore
	LableZeit = $MediumAnker/PanelContainer/GridContainer/GetraeumteZeitScore
	pass # Replace with function body.

func _gameOver(scoreWecker, scoreTime):
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("MenueCamera")
	menueCamera.set_current(true)
	LableWecker = scoreWecker
	LableZeit = scoreTime
	print(scoreTime,scoreWecker)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	get_tree().change_scene("res://Spielwelt.tscn")
