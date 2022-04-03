extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var spawn_index = -1
var spawner


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioStreamPlayer3D.stream = load ("res://Audio/SFX/Wecker_loop.ogg")
	$AudioStreamPlayer3D.play()

func set_spawner(spawner_set):
	spawner = spawner_set
	
func _play_alarm_sfx():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area_body_entered(body):
	print(body)
	spawner.clear_spawnIndex(spawn_index)
	$AudioStreamPlayer3D.stream = load ("res://Audio/SFX/WeckerDestroy.wav")
	$AudioStreamPlayer3D.play()
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()
	pass # Replace with function body.
