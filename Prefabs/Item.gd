extends Spatial

var spielwelt
var is_triggered = false


func _init():
	
	self.add_to_group("items")
	
	
func _ready():
	
	spielwelt = get_tree().get_root().get_node("Spielwelt")


func albtraum():
	
	is_triggered = true
	spielwelt.get_node("Assets/Items").coruptionRise()
	get_node("MeshHappy").is_fading = true
	get_node("MeshEvil").is_fading = true


func _process(delta):
	
	if(!is_triggered):
		var wm = spielwelt.get_node("AllWecker")
		for w in wm.get_children():
			var dist = global_transform.origin.distance_to(w.global_transform.origin)
			if(w.currentRadius > dist):
				albtraum()

