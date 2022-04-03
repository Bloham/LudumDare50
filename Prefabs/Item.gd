extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func albtraum():
#	print(self.name, " ist nun im Alptraumland")
	get_node("MeshHappy").is_fading = true
	get_node("MeshEvil").is_fading = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var wm = get_tree().get_root().get_node("Spielwelt").get_node("AllWecker")
	for w in wm.get_children():
		var wa = w.get_node("WeckerAsset").get_node("WeckerArea")
		var dist = translation.distance_to(wa.global_transform.origin)
		if(wa.currentRadius > dist):
			albtraum()


func _on_Area_area_shape_entered(area_rid, area, area_shape_index, local_shape_index):
	pass
#	if area.get_name() == "WeckerArea":
#		albtraum()
		
