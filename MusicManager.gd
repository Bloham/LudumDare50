extends Node


func _startLayer2FadeIn():
	pass
	
func _stopMusic():
	pass
	
func _testTransition():
	Input.is_action_pressed("MusicTransitionTest")
	_startLayer2FadeIn()
