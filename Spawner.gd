extends Node

var spielwelt
var SpawnLocations = []
var SpawnLocationIndices = []
var rng = RandomNumberGenerator.new()
var timer = Timer
var spawn_location_count = 0
var spawn_attempts = 0

export var difficultyLevel = 1.0
export var wecker_radius = 45


func onGameStart(_spielwelt):
	spielwelt = _spielwelt
	timer = get_node("SpawnTimer")
	SpawnLocations = get_node("SpawnLocations").get_children()
	
	spawn_location_count = SpawnLocations.size()
	for i in SpawnLocations:
		SpawnLocationIndices.append(false)
	spawn_attempts = difficultyLevel * spawn_location_count
	
	timer.set_wait_time((1.0/difficultyLevel)*10.0)
	timer.set_one_shot(false)
	timer.start()
	
	rng.randomize()
	
	print (" Spawner starts timer with ",spawn_location_count," spawn points and ",spawn_attempts," attempts per spawn")

func SpawnWecker():
	var attempt = spawn_attempts
	while attempt > 0:
		attempt -= 1
		var spawn_location_index = round(rng.randf_range(0,spawn_location_count - 1))
		if(SpawnLocationIndices[spawn_location_index] == false):
			attempt = -1
			SpawnLocationIndices[spawn_location_index] = true
			
			var weckerScene = preload("res://Wecker.tscn")
			var wecker = weckerScene.instance()
			wecker.translation = SpawnLocations[spawn_location_index].translation
			wecker.spawn_index = spawn_location_index
			wecker.set_spawner(self)
			wecker.radiusIncrease = difficultyLevel
			wecker.currentRadius = wecker_radius
			
			spielwelt.get_node("AllWecker").add_child(wecker)
			
#			print(" Spawner places wecker at spawn point ",spawn_location_index,"/",spawn_location_count)


func clear_spawnIndex(cleared_index):
		SpawnLocationIndices[cleared_index] = false

func _on_SpawnTimer_timeout():
	SpawnWecker()
