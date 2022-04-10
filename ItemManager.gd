extends Node


# Der Zähler für wie viele corumpierte Items es gibt. 
onready var coruptionCounter = 0
onready var spielwelt = get_tree().get_root().get_node("Spielwelt")

var ItemsAufMap = 0
var turning_eyes
var eye_index = 0

export var gameOverDelay = 15


func _ready():
	ItemsAufMap = get_tree().get_nodes_in_group("items").size()
	print("Session started with ",ItemsAufMap," items on the map")
	coruptionCounter = ItemsAufMap
	
	turning_eyes = []
	for item in get_tree().get_nodes_in_group("items"):
		if "Hedge" in item.name:
				turning_eyes.append(item)
#	print ("There are ",turning_eyes.size()," eyes to turn")
	
	pass # Replace with function body.

#diese Funktion benutzen um die Coruption hochzählen zu lassen
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
		spielwelt.get_node("Assets").get_node("SkyClock").gameOver()
		print("game over timer startet")
		yield(t, "timeout")
		spielwelt.gameover()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for turning_eye in turning_eyes:
		if turning_eye.is_triggered:
			turning_eye.look_at(spielwelt.player_instance.translation, Vector3.UP)
#		print ("turning eye ",turning_eye.name)
#	var turning_eye = turning_eyes[eye_index]
#	eye_index = (eye_index+1)%turning_eyes.size()
	pass
