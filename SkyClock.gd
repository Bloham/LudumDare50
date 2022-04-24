extends Spatial

var rotation_speed_L = .01
var rotation_speed_S = 60 * rotation_speed_L
var rot
var pointer_L
var pointer_S_Rotation = Vector3.UP
var pointer_S_Rotation_Distance = Vector3(0,6,0)

func _ready():
	pointer_L = get_node("Mesh_SkyClock_PointerL")
	#pointer_S = get_node("Mesh_SkyClock_PointerS")


func _process(delta):
	pointer_L.rotate(Vector3(0,1,0),delta * rotation_speed_L)
	#pointer_S.rotate(Vector3(0,1,0),delta * rotation_speed_S)
	
	
func gameOver():
	
	get_node("Mesh_SkyClock_BG").is_fading = true


func _on_Timer_timeout():
	$Tween.interpolate_property($Mesh_SkyClock_PointerS, "rotation_degrees", pointer_S_Rotation, pointer_S_Rotation + pointer_S_Rotation_Distance, 1,Tween.TRANS_ELASTIC, Tween.EASE_IN_OUT)
	pointer_S_Rotation += pointer_S_Rotation_Distance
	$Tween.start()
