extends Control

export var music_volume = 1.0
export var audio_volume = 1.0
export var music_muted = false
export var audio_muted = false
var volume_increment = .1


func _activate_menu():
	
	$MediumAnker/VBoxContainer/Return_Button.grab_focus()
	$MediumAnker/VBoxContainer/ToggleScreen_Button.text = "Fullscreen: " + str(Settings.is_fullscreen)
	$MediumAnker/VBoxContainer/Music_Buttons/Button_Info.text = "Music Volume: " + str(round(100 * Settings.scalar_music)) + "%"
	$MediumAnker/VBoxContainer/Audio_Buttons/Button_Info.text = "Audio Volume: " + str(round(100 * Settings.scalar_audio)) + "%"
	$MediumAnker/VBoxContainer/GamepadLook_Butons/Button_Info.text = "Gamepad Look: " + str(round(100 * Settings.scalar_gamepad_look)) + "%"
	$MediumAnker/VBoxContainer/MouseLook_Buttons/Button_Info.text = "Mouse Look: " + str(round(100 * Settings.scalar_mouse_look)) + "%"
	self.visible = true


func _on_toggle_fullscreen_button_pressed():
	
	var fullscreen_mode_label = get_tree().get_root().get_node("Spielwelt")._toggle_fullscreen()
	$MediumAnker/VBoxContainer/ToggleScreen_Button.text = "Fullscreen: " + fullscreen_mode_label


func _on_return_button_pressed():
	
	self.visible = false
	get_tree().get_root().get_node("Spielwelt").save_settings()
	get_tree().get_root().get_node("Spielwelt/Other/UI/MainMenu").activate_menu()


func _on_less_music_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_music_volume(-volume_increment)
	$MediumAnker/VBoxContainer/Music_Buttons/Button_Info.text = "Music Volume: " + label

func _on_more_music_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_music_volume(volume_increment)
	$MediumAnker/VBoxContainer/Music_Buttons/Button_Info.text = "Music Volume: " + label


func _on_less_audio_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_audio_volume(-volume_increment)
	$MediumAnker/VBoxContainer/Audio_Buttons/Button_Info.text = "Audio Volume: " + label

func _on_more_audio_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_audio_volume(volume_increment)
	$MediumAnker/VBoxContainer/Audio_Buttons/Button_Info.text = "Audio Volume: " + label


func _on_toggle_music_button_pressed():
	music_muted = not music_muted


func _on_toggle_audio_button_pressed():
	audio_muted = not audio_muted


func _on_less_mouse_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_mouse_look(-volume_increment)
	$MediumAnker/VBoxContainer/MouseLook_Buttons/Button_Info.text = "Mouse Look: " + label

func _on_more_mouse_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_mouse_look(volume_increment)
	$MediumAnker/VBoxContainer/MouseLook_Buttons/Button_Info.text = "Mouse Look: " + label


func _on_less_gamepad_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_gamepad_look(-volume_increment)
	$MediumAnker/VBoxContainer/GamepadLook_Butons/Button_Info.text = "Gamepad Look: " + label

func _on_more_gamepad_button_pressed():
	var label = get_tree().get_root().get_node("Spielwelt").change_gamepad_look(volume_increment)
	$MediumAnker/VBoxContainer/GamepadLook_Butons/Button_Info.text = "Gamepad Look: " + label
