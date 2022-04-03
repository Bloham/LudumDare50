extends Node

#var WeckersArray = []
var WeckersAnzahl = 0
var rng = RandomNumberGenerator.new()
var SpawnLocations = []
var SpawnLocationIndices = []
var t = Timer

export var difficultyLevel = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	#WeckersArray = get_children()
	SpawnLocations = get_node("SpawnLocations").get_children()
	t = get_node("SpawnTimer")
	WeckersAnzahl = get_node("SpawnLocations").get_child_count()
	print(SpawnLocations)
	SpawnLocationIndices = []
	for i in SpawnLocations:
		SpawnLocationIndices.append(false)
	#Timer that spawns the Wecker
	t.set_wait_time(difficultyLevel*10)
	t.set_one_shot(false)


func onGameStart():
	t.start()
	yield(t, "timeout")
	SpawnWecker()

func SpawnWecker():
	var weckerNummerX = round(rng.randf_range(0,WeckersAnzahl))
	if(SpawnLocationIndices[weckerNummerX] == false):
		SpawnLocationIndices[weckerNummerX] = true
		print("Random Wecker Nummer ",weckerNummerX, " is spawning")
