extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var currentRadius = 45
export var spawn_index = -1

var spielwelt
var radiusIncrease = 1.0
var radiusIncrease_corruptionFactor = 2.0
var spawner
var animation


# Called when the node enters the scene tree for the first time.
func _ready():
	spielwelt = get_tree().get_root().get_node("Spielwelt")
	$AudioStreamPlayer3D.stream = load ("res://Audio/SFX/Wecker_loop.ogg")
	$AudioStreamPlayer3D.play()
	animation = get_node("WeckerAsset").get_node("AnimationPlayer")

func set_spawner(spawner_set):
	spawner = spawner_set
	
func _play_alarm_sfx():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var increase = radiusIncrease + radiusIncrease_corruptionFactor * spielwelt.corruption_scalar
	currentRadius += delta*increase
	pass


func _on_Area_body_entered(body):
#	print(body)
	spawner.clear_spawnIndex(spawn_index)
	$AudioStreamPlayer3D.stream = load ("res://Audio/SFX/WeckerDestroy.wav")
	$AudioStreamPlayer3D.play()
	animation.play("destroy")
	
	get_tree().get_root().get_node("Spielwelt").score_wecker+=1
	print(get_tree().get_root().get_node("Spielwelt").score_wecker)
	
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()
	pass # Replace with function body.
