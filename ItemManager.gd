extends Node


# Der Zähler für wie viele corumpierte Items es gibt. 
onready var coruptionCounter = 0

var ItemsAufMap = 0

export var gameOverDelay = 15


func _ready():
	ItemsAufMap = get_child_count()
	print("Items auf der Map: ",ItemsAufMap)
	coruptionCounter = ItemsAufMap
	pass # Replace with function body.

#diese Funktion benutzen um die Coruption hochzählen zu lassen
func coruptionRise():
	coruptionCounter -= 1
	print("Current Coruption: ",coruptionCounter, " / ", ItemsAufMap)
	if coruptionCounter <= 0:
		#initiate Game Over in X seconds
		var t = Timer.new()
		t.set_wait_time(gameOverDelay)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		print("game over timer startet")
		yield(t, "timeout")
		gameOver()
		
		


func gameOver():
	get_tree().change_scene(("res://EndGame.tscn"))
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass