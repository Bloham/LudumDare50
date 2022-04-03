extends Area

export var radiusIncrease = 5

onready var collider = get_node("CollisionShape").shape
onready var timer = get_node("Timer")

export var currentRadius = 45

# Called when the node enters the scene tree for the first time.
func _ready():
	collider.radius = currentRadius
	pass # Replace with function body.

func erweitereRadius():
	currentRadius = currentRadius + radiusIncrease
	collider.radius = currentRadius
	#print(self.name," Radius wächst auf: ",collider.radius)
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	erweitereRadius()
	pass # Replace with function body.
