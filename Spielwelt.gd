extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var corruption_scalar = 0.0

var player_instance = self
var environment_instance
var terrain_material

var score_time = 0.0
var score_wecker = 0

var is_fullscreen = true

func _ready():
	var lightning = load("res://DirectionalLight.tscn")
	var lightning_instance = lightning.instance()
	lightning_instance.set_name("DirectionalLight")
	
	var environment = load("res://WorldEnvironment.tscn")
	environment_instance = environment.instance()
	environment_instance.set_name("WorldEnviorment")
	
	add_child(lightning_instance)
	add_child(environment_instance)
	
	terrain_material = get_node("Assets/Boden/Terrain/Terrain_low")
	

func _init():
	_toggle_fullscreen()
	pass
	
func _toggle_fullscreen():
	is_fullscreen = !is_fullscreen
	OS.window_fullscreen = is_fullscreen
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	score_time += delta
	terrain_material.get_active_material(0).set_shader_param("corruption_scalar", corruption_scalar)
	
func start_score():
	score_time = 0.0
	score_wecker = 0
	
func gameover():
#	print("scores: ",score_wecker,", ",score_time)
	get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue")._gameOver(score_wecker, round(score_time))
