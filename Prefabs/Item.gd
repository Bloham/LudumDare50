extends Spatial

var is_triggered = false
var searchTimer = Timer
var searchDelay

export var searchDelayMin = 1.0
export var searchDelayMax = 2.0

onready var spielwelt = get_tree().get_root().get_node("Spielwelt")
onready var all_wecker = spielwelt.get_node("AllWecker")



func _init():
	
	self.add_to_group("items")
	
	
func _ready():
	
	searchTimer = Timer.new()
	searchDelay = rand_range(searchDelayMin, searchDelayMax)
	searchTimer.set_wait_time(searchDelay)
	searchTimer.connect("timeout", self, "lookForNewWecker")
	add_child(searchTimer)
	searchTimer.start()
#	lookForNewWecker()


func albtraum():
	
	is_triggered = true
	spielwelt.get_node("Assets/Items").coruptionRise()
	get_node("MeshHappy").is_fading = true
	get_node("MeshEvil").is_fading = true


#func _physics_process(_delta):
#	if(!is_triggered):
#		for w in all_wecker.get_children():
#			var dist = global_transform.origin.distance_to(w.global_transform.origin)
#			if(w.currentRadius > dist):
#				albtraum()

func lookForNewWecker():
	if(!is_triggered):
		for w in all_wecker.get_children():
			var dist = global_transform.origin.distance_to(w.global_transform.origin)
			if(w.currentRadius > dist):
				albtraum()

