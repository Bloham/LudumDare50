extends Node


#onready var _anim_player := $AnimationPlayer
#onready var _layer_1 := $MusicLayer1
#onready var _layer_2 := $MusicLayer2

var Layer2IsPlaying = false

func _process(delta):
	_startLayer2FadeIn()
	

func _startLayer2FadeIn():
	
	if get_tree().get_root().get_node("Spielwelt").corruption_scalar >0.4 and Layer2IsPlaying==false:
		Layer2IsPlaying = true
		print ("Start Fade in")
		$AnimationPlayer.play("FadeInLayer2")
	else:
		pass


#func _stopMusic():
#	pass
	
#func _testTransition():
#	if Input.is_action_pressed("MusicTransitionTest"):
#		print("test input")
#		_startLayer2FadeIn()
