extends Control

func _ready():
	$MediumAnker/VBoxContainer/StartButton.grab_focus()
	




func _on_StartButton_pressed():
	self.visible = false
	
	var player = load("res://Player.tscn")
	var player_instance = player.instance()
	
	
	player_instance.set_name("Player")
	var spielwelt = get_tree().get_root().get_node("Spielwelt")
	spielwelt.player_instance = player_instance
	add_child(player_instance)
	spielwelt.onGameStart()


func _on_QuitButton_pressed():
	get_tree().quit()

