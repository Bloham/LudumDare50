extends Control

var menueCamera
var playerCamera


func _activatePause():
	
	$MediumAnker/VBoxContainer/Continue_Button.grab_focus()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	playerCamera = get_tree().get_root().get_node("Spielwelt").player_instance.get_node("Camera")
	get_tree().paused = true
	self.visible = true
	menueCamera = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("MenueCamera")
	menueCamera.set_current(true)
#	print(playerCamera)


func _on_ContinetButton_pressed():
	
	self.visible = false
	get_tree().paused = false
	playerCamera.set_current(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _on_RestartButton_pressed():
	
	get_tree().paused = false
	var spiel = get_tree().get_root().get_node("Spielwelt")
	if spiel.level_index == 0:
		get_tree().change_scene("res://Spielwelt_restart_version_0.tscn")
	else:
		get_tree().change_scene("res://Spielwelt_restart_version_1.tscn")


func _on_MainMenu_Button_pressed():
	
	get_tree().paused = false
	get_tree().change_scene("res://Spielwelt.tscn")


func _on_QuitButton_pressed():
	
	get_tree().quit()
