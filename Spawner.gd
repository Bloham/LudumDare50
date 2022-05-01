extends Node

var spielwelt
var SpawnLocations = []
var SpawnLocationIndices = []
var rng = RandomNumberGenerator.new()
var timer = Timer
var spawn_location_count = 0

export var difficultyLevel = 0.9
export var wecker_radius = 45

var max_wecker = 30
var current_wecker = 0


func onGameStart(_spielwelt):
	
	spielwelt = _spielwelt
	timer = get_node("SpawnTimer")
	SpawnLocations = get_node("SpawnLocations").get_children()
	
	spawn_location_count = SpawnLocations.size()
	for i in SpawnLocations:
		SpawnLocationIndices.append(false)
	
	timer.set_wait_time((1.0/difficultyLevel)*10.0)
	timer.set_one_shot(false)
	timer.start()
	
	rng.randomize()
	
#	print (" - Spawner starts timer with ",spawn_location_count," spawn points")


func clear_spawnIndex(cleared_index):
	
		SpawnLocationIndices[cleared_index] = false


func _on_SpawnTimer_timeout():
	
	if current_wecker < max_wecker:
		try_Spawn()


func try_Spawn():
	
	var attempt = spawn_location_count
	while attempt > 0:
		attempt -= 1
		var spawn_location_index = round(rng.randf_range(0,spawn_location_count - 1))
		if(SpawnLocationIndices[spawn_location_index] == false):
			attempt = -1
			SpawnLocationIndices[spawn_location_index] = true
			Spawn(spawn_location_index)


func Spawn(spawn_location_index):

	current_wecker += 1
	
	SpawnLocationIndices[spawn_location_index] = true
	
	var weckerScene = preload("res://Wecker.tscn")
	var wecker = weckerScene.instance()
	
	wecker.set_spawner(self)
	wecker.spawn_index = spawn_location_index
	wecker.radiusIncrease = difficultyLevel
	wecker.currentRadius = wecker_radius
	wecker.translation = SpawnLocations[spawn_location_index].translation
	wecker.rotation = SpawnLocations[spawn_location_index].rotation
	spielwelt.get_node("AllWecker").add_child(wecker)
	
#	print(" Spawner places wecker at spawn point ",spawn_location_index,"/",spawn_location_count)
