extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var WeckersArray = []
var WeckersAnzahl = 0
var rng = RandomNumberGenerator.new()
var SpawnerLocations = []
var SpawnerIndex = []
var t = Timer

export var difficultyLevel = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	WeckersArray = get_children()
	SpawnerLocations = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("Spawner")
	SpawnerIndex = SpawnerLocations
	t = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("SpawnTimer")
	WeckersAnzahl = SpawnerLocations.get_child_count()
	print(SpawnerLocations)
	
	#Timer that spawns the Wecker
	t.set_wait_time(difficultyLevel*5)
	t.set_one_shot(false)


func onGameStart():
	t.start()
	yield(t, "timeout")
	SpawnWecker()

func SpawnWecker():
	var weckerNummerX = round(rng.randf_range(0,WeckersAnzahl))
	print("Random Wecker Nummer ",weckerNummerX, " is spawning")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
