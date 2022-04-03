extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var WeckersArray = []
var WeckersAnzahl = 0
var rng = RandomNumberGenerator.new()

export var difficultyLevel = 2

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	WeckersArray = get_children()
	WeckersAnzahl = get_child_count()
	for wk in WeckersArray:
		wk.translation.y += 1000
		print(wk.translation.y)

	 # Replace with function body.

func onGameStart():
	var t = Timer.new()
	t.set_wait_time(gameOverDelay)
	t.set_one_shot(true)
	self.add_child(t)
	t.start()
	print("game over timer startet")
	yield(t, "timeout")
	pass

func SpawnWecker():
	var weckerNummerX = rng.randf_range(0,WeckersAnzahl)
	print("Random Wecker Nummer ",weckerNummerX, " is spawning")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
