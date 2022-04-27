extends Control

var menueCamera
var playerCamera
var playerVignette


func _activatePause():
	
	$MediumAnker/VBoxContainer/Continue_Button.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	playerCamera = get_tree().get_root().get_node("Spielwelt").player_instance.get_node("Camera")
	playerVignette = get_tree().get_root().get_node("Spielwelt").player_instance.get_node("Vignette")
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt/Other/UI/Camera/MenueCamera")
	menueCamera.set_current(true)
#	print(playerCamera)


func _on_ContinetButton_pressed():
	
	self.visible = false
	get_tree().paused = false
	playerCamera.set_current(true)
	playerVignette.visible = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	var vignette = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("Vignette")
	vignette.visible = true


func _on_RestartButton_pressed():

	get_tree().get_root().get_node("Spielwelt").restart()


func _on_MainMenu_Button_pressed():
	
	Settings.restart_level = -1
	get_tree().paused = false
	get_tree().change_scene("res://Spielwelt.tscn")
