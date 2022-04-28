extends Control

export var music_volume = 1.0
export var audio_volume = 1.0
export var music_muted = false
export var audio_muted = false
var volume_increment = .1


func _activate_menu():
	
	$MediumAnker/VBoxContainer/Return_Button.grab_focus()
	$MediumAnker/VBoxContainer/Highscores_0/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_0))
	$MediumAnker/VBoxContainer/Highscores_0/Button_Info_Wecker.text = str(Settings.highscore_wecker_0)
	$MediumAnker/VBoxContainer/Highscores_1/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_1))
	$MediumAnker/VBoxContainer/Highscores_1/Button_Info_Wecker.text = str(Settings.highscore_wecker_1)
	$MediumAnker/VBoxContainer/Highscores_2/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_2))
	$MediumAnker/VBoxContainer/Highscores_2/Button_Info_Wecker.text = str(Settings.highscore_wecker_2)
	self.visible = true


func _on_return_button_pressed():
	
	self.visible = false
	get_tree().get_root().get_node("Spielwelt").save_settings()
	get_tree().get_root().get_node("Spielwelt/Other/UI/MainMenu").activate_menu()


func _on_reset_button_pressed():
	
	Settings.highscore_time_0 = 0
	Settings.highscore_wecker_0 = 0
	Settings.highscore_time_1 = 0
	Settings.highscore_wecker_1 = 0
	Settings.highscore_time_2 = 0
	Settings.highscore_wecker_2 = 0
	$MediumAnker/VBoxContainer/Highscores_0/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_0))
	$MediumAnker/VBoxContainer/Highscores_0/Button_Info_Wecker.text = str(Settings.highscore_wecker_0)
	$MediumAnker/VBoxContainer/Highscores_1/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_1))
	$MediumAnker/VBoxContainer/Highscores_1/Button_Info_Wecker.text = str(Settings.highscore_wecker_1)
	$MediumAnker/VBoxContainer/Highscores_2/Button_Info_Duration.text = str(Settings.get_highscore_time(Settings.highscore_time_2))
	$MediumAnker/VBoxContainer/Highscores_2/Button_Info_Wecker.text = str(Settings.highscore_wecker_2)
