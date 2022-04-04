extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var menueCamera
var playerCamera

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _activatePause():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	playerCamera = get_tree().get_root().get_node("Spielwelt").player_instance.get_node("Camera")
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("MenueCamera")
	menueCamera.set_current(true)
	print(playerCamera)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ContinetButton_pressed():
	self.visible = false
	get_tree().paused = false
	playerCamera.set_current(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_StartButton_pressed():
	get_tree().change_scene("res://Spielwelt.tscn")


func _on_QuitButton_pressed():
	get_tree().quit()

