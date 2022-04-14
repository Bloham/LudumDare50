extends Control


func _ready():
	
	$MediumAnker/VBoxContainer/StartButtons/StartButton_Level1.grab_focus()


func _on_StartButton_pressed(var _level_index):
	
	self.visible = false
	
	var spielwelt = get_tree().get_root().get_node("Spielwelt")
	spielwelt.onGameStart(_level_index)


func _on_quit_button_pressed():
	
	get_tree().quit()
