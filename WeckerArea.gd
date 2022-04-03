extends Area


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var radius = get_node("CollisionShape")
onready var timer = get_node("Timer")

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Der Wecker Radius ist: ",radius.shape)
	pass # Replace with function body.

func erweitereRadius():
	radius.shape += 10
	print(radius)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
