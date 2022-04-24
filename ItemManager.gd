extends Node

onready var coruptionCounter = 0
onready var spielwelt = get_tree().get_root().get_node("Spielwelt")

var ItemsAufMap = 0
var turning_eyes
var eye_index = 0

export var gameOverDelay = 15


func _ready():
	
	ItemsAufMap = get_tree().get_nodes_in_group("items").size()
#	print("- ther are ",ItemsAufMap," items on the map")
	coruptionCounter = ItemsAufMap
	
	turning_eyes = []
	for item in get_tree().get_nodes_in_group("items"):
		if "Hedge" in item.name:
				turning_eyes.append(item)
#	print ("There are ",turning_eyes.size()," eyes to turn")


func coruptionRise():
	
	coruptionCounter -= 1
	spielwelt.corruption_scalar = 1 - coruptionCounter/(1.0*ItemsAufMap)
#	print("Current Coruption: ",coruptionCounter, " / ", ItemsAufMap," (",(100*spielwelt.corruption_scalar),"%)")
	if coruptionCounter <= 0:
		#initiate Game Over in X seconds
		var t = Timer.new()
		t.set_wait_time(gameOverDelay)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		var endAnimation = get_tree().get_root().get_node("Spielwelt")
		endAnimation.get_node("Player")._playAnimation()
		spielwelt.get_node("Assets").get_node("SkyClock").gameOver()
		yield(t, "timeout")
		endAnimation.get_node("Player").get_node("Vignette").visible = false
		spielwelt.gameover()
		


func _process(delta):
	
	for turning_eye in turning_eyes:
		if turning_eye.is_triggered:
			turning_eye.look_at(spielwelt.player_instance.translation, Vector3.UP)
