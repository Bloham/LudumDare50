extends Control


func _ready():
	
	activate_menu()

func activate_menu():
	
	self.visible = true
	$MediumAnker/VBoxContainer/Buttons1/StartButton_Level1.grab_focus()


func _on_StartButton_pressed(var _level_index):
	
	self.visible = false
	
	Settings.restart_level = _level_index
	var spielwelt = get_tree().get_root().get_node("Spielwelt")
	spielwelt.onGameStart()
	
	var vignette = get_tree().get_root().get_node("Spielwelt/Other/UI/Vignette")
	vignette.visible = true

func _on_settings_button_pressed():
	
	self.visible = false
	get_tree().get_root().get_node("Spielwelt/Other/UI/SettingsMenu")._activate_menu()


func _on_quit_button_pressed():
	
	get_tree().get_root().get_node("Spielwelt").close_application()
