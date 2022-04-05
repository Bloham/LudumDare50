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
	menueCamera = get_tree().get_root().get_node("Spielwelt/Other/UI/MenueCamera")
	menueCamera.set_current(true)
	LableWecker.text = String(scoreWecker)
	LableZeit.text = String(scoreTime)
	LableZeit.text += " seconds"
	print(scoreTime,scoreWecker)


func _on_QuitButton_pressed():
	get_tree().quit()


func _on_StartButton_pressed():
	get_tree().paused = false
	get_tree().change_scene("res://Spielwelt.tscn")
