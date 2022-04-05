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
#	print(SpawnLocations)
	SpawnLocationIndices = []
	for i in SpawnLocations:
		SpawnLocationIndices.append(false)
	#Timer that spawns the Wecker
	t.set_wait_time(difficultyLevel*10)
	t.set_one_shot(false)


func onGameStart():
	SpawnLocationIndices = []
	for i in SpawnLocations:
		SpawnLocationIndices.append(false)
	t.start()

func SpawnWecker():
	print("SpawnWecker tries to spawn a Random Wecker at 1 out of ",WeckersAnzahl," locations")
	var weckerNummerX = round(rng.randf_range(0,WeckersAnzahl - 1))
	if(SpawnLocationIndices[weckerNummerX] == false):
		SpawnLocationIndices[weckerNummerX] = true
		var weckerScene = preload("res://Wecker.tscn")
		var Wecker = weckerScene.instance()
		Wecker.translation = SpawnLocations[weckerNummerX].translation
		Wecker.spawn_index = weckerNummerX
		Wecker.set_spawner(self)
		var spielwelt = get_tree().get_root().get_node("Spielwelt")
		spielwelt.get_node("AllWecker").add_child(Wecker)
		print("Random Wecker ",Wecker.name," is spawning at spawn location nr ",weckerNummerX)
	else:
		print("Random Wecker cant be spawned since its spawn location ",weckerNummerX," is occupied")
		
func clear_spawnIndex(cleared_index):
		SpawnLocationIndices[cleared_index] = false

func _on_SpawnTimer_timeout():
	SpawnWecker()
