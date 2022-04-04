extends Control

func _ready():
	$VBoxContainer/StartButton.grab_focus()



func _on_StartButton_pressed():
	self.visible = false
	var menueCamera = find_node("MenueCamera")
	
	var player = load("res://Player.tscn")
	var player_instance = player.instance()
	
	var WeckerSpawnerStartet = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("Spawner")
	
	player_instance.set_name("Player")
	get_tree().get_root().get_node("Spielwelt").player_instance = player_instance
	add_child(player_instance)
	
	WeckerSpawnerStartet.onGameStart()
	
	


func _on_QuitButton_pressed():
	get_tree().quit()
