extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Weckers = []

# Called when the node enters the scene tree for the first time.
func _ready():
	Weckers = get_children()
	print(Weckers)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
