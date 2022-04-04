extends Control

func _ready():
	$MediumAnker/VBoxContainer/StartButton.grab_focus()
	




func _on_StartButton_pressed():
	self.visible = false
	
	var player = load("res://Player.tscn")
	var player_instance = player.instance()
	
	var WeckerSpawnerStartet = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("Spawner")
	
	player_instance.set_name("Player")
	var spielwelt = get_tree().get_root().get_node("Spielwelt")
	spielwelt.player_instance = player_instance
	spielwelt.start_score()
	add_child(player_instance)
	
	WeckerSpawnerStartet.onGameStart()
	
	


func _on_QuitButton_pressed():
	get_tree().quit()

