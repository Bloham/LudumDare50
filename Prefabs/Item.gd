extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spielwelt


# Called when the node enters the scene tree for the first time.
func _ready():
	spielwelt = get_tree().get_root().get_node("Spielwelt")

func albtraum():
#	print(self.name, " ist nun im Alptraumland")
	get_node("MeshHappy").is_fading = true
	get_node("MeshEvil").is_fading = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var wm = spielwelt.get_node("AllWecker")
	for w in wm.get_children():
		var wa = w.get_node("WeckerAsset").get_node("WeckerArea")
		var dist = translation.distance_to(wa.global_transform.origin)
		if(wa.currentRadius > dist):
			albtraum()
