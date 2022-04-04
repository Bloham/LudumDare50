extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var corruption_scalar = 0.0

var player_instance = self
var terrain_material

var score_time = 0
var score_wecker = 0

func _ready():
	var lightning = load("res://DirectionalLight.tscn")
	var lightning_instance = lightning.instance()
	lightning_instance.set_name("DirectionalLight")
	
	var envorment = load("res://WorldEnvironment.tscn")
	var envorment_instance = envorment.instance()
	envorment_instance.set_name("WorldEnviorment")
	
	add_child(lightning_instance)
	add_child(envorment_instance)
	
	terrain_material = get_node("Assets/Boden/Terrain/Terrain_low")
	

func _init():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	terrain_material.get_active_material(0).set_shader_param("corruption_scalar", corruption_scalar)
	
func start_score():
	score_time = 0
	score_wecker = 0
	
func gameover():
	get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue")._gameOver(score_wecker, score_time)
