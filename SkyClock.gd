extends Spatial


var rotation_speed_L = .01
var pointer_L
var pointer_S


func _ready():
	pointer_L = get_node("Mesh_SkyClock_PointerL")
	pointer_S = get_node("Mesh_SkyClock_PointerS")
var rotation_speed_S = 60 * rotation_speed_L

func _process(delta):
	pointer_L.rotate(Vector3(0,1,0),delta * rotation_speed_L)
	pointer_S.rotate(Vector3(0,1,0),delta * rotation_speed_S)
	
func gameOver():
	print ("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX")
	pass
