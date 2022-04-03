extends Node


# Der Zähler für wie viele corumpierte Items es gibt. 
onready var coruptionCounter = 0

var ItemsAufMap = 0


func _ready():
	ItemsAufMap = get_child_count()
	print("Items auf der Map: ",ItemsAufMap)
	coruptionCounter = ItemsAufMap
	pass # Replace with function body.

#diese Funktion benutzen um die Coruption hochzählen zu lassen
func coruptionRise():
	coruptionCounter -= 1
	if coruptionCounter <= 0:
		get_tree().change_scene(("res://EndGame.tscn"))
		print("Current Coruption: ",coruptionCounter, " / ", ItemsAufMap)
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
