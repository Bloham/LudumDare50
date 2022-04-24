extends Spatial

var spielwelt
var is_triggered = false
var searchTimer = Timer
var wm = []

export var searchDelay = 4


func _init():
	
	self.add_to_group("items")
	
	
func _ready():
	
	spielwelt = get_tree().get_root().get_node("Spielwelt")
	searchTimer = Timer.new()
	searchTimer.set_wait_time(searchDelay)
	searchTimer.connect("timeout", self, "lookForNewWecker")
	add_child(searchTimer)
	searchTimer.start()
	lookForNewWecker()


func albtraum():
	
	is_triggered = true
	spielwelt.get_node("Assets/Items").coruptionRise()
	get_node("MeshHappy").is_fading = true
	get_node("MeshEvil").is_fading = true


func _physics_process(delta):
	if(!is_triggered):
		for w in wm.get_children():
			var dist = global_transform.origin.distance_to(w.global_transform.origin)
			if(w.currentRadius > dist):
				albtraum()

func lookForNewWecker():
	wm = spielwelt.get_node("AllWecker")

