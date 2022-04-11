extends Control


var level_index = 1


func _ready():
	$MediumAnker/VBoxContainer/StartButton.grab_focus()


func _on_StartButton_pressed(var _level_index):
	self.visible = false
	
	var player = load("res://Player.tscn")
	var player_instance = player.instance()
	
	level_index = _level_index
	
	player_instance.set_name("Player")
	var spielwelt = get_tree().get_root().get_node("Spielwelt")
	spielwelt.player_instance = player_instance
	add_child(player_instance)
	spielwelt.onGameStart(level_index)


func _on_QuitButton_pressed():
	get_tree().quit()
