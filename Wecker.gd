extends Spatial


export var currentRadius = 45
export var spawn_index = -1

var spielwelt
var radiusIncrease = 1.0
var radiusIncrease_corruptionFactor = 2.0
var radius_deactivation = 9
var is_deactivated = false;
var spawner
var animation


# audio tuning variables
var audio_db = -10						# volume of the alarm sound
var audio_max_db = -20					# maximum volume of the alarm sound
var audio_deactivation_db = -28			# volume of the deactivation sound
var audio_radius = 48					# range of the sound effects
var audio_attenuation_model = 2			# falloff model (0 = linear, 1 = exp, 2 = log)
var audio_attenuation_filter_db = -3.6	# falloff strength (I think)


func _ready():
	spielwelt = get_tree().get_root().get_node("Spielwelt")
	var audio = $AudioStreamPlayer3D
	_wecker_stellen(audio)
	audio.set_emission_angle_enabled(false)
	audio.stream = load ("res://Audio/SFX/Wecker_loop.ogg")
	audio.play()
	animation = get_node("WeckerAsset").get_node("AnimationPlayer")


func _wecker_stellen(audio):
	audio.set_unit_db(audio_db)
	audio.set_max_db(audio_max_db)
	audio.set_attenuation_model(audio_attenuation_model)
	audio.set_attenuation_filter_db(audio_attenuation_filter_db)
	audio.unit_size = audio_radius


func set_spawner(spawner_set):
	spawner = spawner_set


func _get_shaderMaterial():
	return self.get_node("WeckerAsset/SM_Clock_Body").get_active_material(0)

func _process(delta):
#	self.get_node("WeckerAsset/SM_Clock_Body").get_active_material(0).set_shader_param("corruption_scalar", spielwelt.corruption_scalar)
	if !is_deactivated:
		currentRadius += delta*(radiusIncrease + radiusIncrease_corruptionFactor * spielwelt.corruption_scalar)
		var distance_toPlayer = translation.distance_to(spielwelt.player_instance.global_transform.origin)
		if radius_deactivation > distance_toPlayer:
			_deactivate()


func _deactivate():
	is_deactivated = true
	spawner.clear_spawnIndex(spawn_index)
	$AudioStreamPlayer3D.set_unit_db(audio_deactivation_db)
	$AudioStreamPlayer3D.stream = load ("res://Audio/SFX/WeckerDestroy.wav")
	$AudioStreamPlayer3D.play()
	animation.play("destroy")
	
	spielwelt.score_wecker+=1
	yield(get_tree().create_timer(2.0), "timeout")
	queue_free()
