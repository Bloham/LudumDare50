extends Spatial


export var corruption_scalar = 0.0

var player_instance = self
var environment_instance
var lightning_instance
var terrain_material

var ambient_colour_initial
var light_colour_initial
var fog_colour_initial
var bg_colour_initial
export var light_colour_final = Color(0.9,0.1,0)
export var ambient_colour_final = Color(0.3,0.6,0)
export var bg_colour_final = Color(0.6,0.22,0.12)

var score_time = 0.0
var score_wecker = 0

var is_fullscreen = true

var M_wecker;


func _ready():
	var lightning = load("res://DirectionalLight.tscn")
	lightning_instance = lightning.instance()
	lightning_instance.set_name("DirectionalLight")
	light_colour_initial = lightning_instance.get_color()
	
	add_child(lightning_instance)
	
	var environment = load("res://WorldEnvironment.tscn")
	environment_instance = environment.instance()
	environment_instance.set_name("WorldEnviorment")
	ambient_colour_initial = environment_instance.get_environment().get_ambient_light_color()
	fog_colour_initial = environment_instance.get_environment().get_fog_color()
	bg_colour_initial = environment_instance.get_environment().get_bg_color()
	
	add_child(environment_instance)
	
	terrain_material = get_node("Assets/Boden/Terrain/Terrain_low")
	
	var weckerScene = preload("res://Wecker.tscn")
	var wecker = weckerScene.instance()
	M_wecker = wecker._get_shaderMaterial()


func _init():
	OS.window_fullscreen = is_fullscreen
	pass
	
func _toggle_fullscreen():
	is_fullscreen = !is_fullscreen
	OS.window_fullscreen = is_fullscreen
	pass


func onGameStart():
	score_time = 0.0
	score_wecker = 0
	var WeckerSpawner = get_tree().get_root().get_node("Spielwelt/Assets/Spawner")
	WeckerSpawner.onGameStart(self)


func _process(delta):
	score_time += delta
	_change_environment()


func _change_environment():
	M_wecker.set_shader_param("corruption_scalar", corruption_scalar)
	
	terrain_material.get_active_material(0).set_shader_param("corruption_scalar", corruption_scalar)
	
	var uncorruption_scalar = 1 - corruption_scalar
	
	var r = corruption_scalar * light_colour_final.r + uncorruption_scalar * light_colour_initial.r
	var g = corruption_scalar * light_colour_final.g + uncorruption_scalar * light_colour_initial.g
	var b = corruption_scalar * light_colour_final.b + uncorruption_scalar * light_colour_initial.b
	lightning_instance.light_color = Color(r,g,b)
#	lightning_instance.light_energy = 2 + 2 * corruption_scalar
	
	r = corruption_scalar * ambient_colour_final.r + uncorruption_scalar * ambient_colour_initial.r
	g = corruption_scalar * ambient_colour_final.g + uncorruption_scalar * ambient_colour_initial.g
	b = corruption_scalar * ambient_colour_final.b + uncorruption_scalar * ambient_colour_initial.b
	b = corruption_scalar * ambient_colour_final.b + uncorruption_scalar * ambient_colour_initial.b
	environment_instance.get_environment().set_ambient_light_color(Color(r,g,b))
	
	r = corruption_scalar * bg_colour_final.r + uncorruption_scalar * fog_colour_initial.r
	g = corruption_scalar * bg_colour_final.g + uncorruption_scalar * fog_colour_initial.g
	b = corruption_scalar * bg_colour_final.b + uncorruption_scalar * fog_colour_initial.b
	b = corruption_scalar * bg_colour_final.b + uncorruption_scalar * fog_colour_initial.b
	environment_instance.get_environment().set_fog_color(Color(r,g,b))
	
	r = corruption_scalar * bg_colour_final.r + uncorruption_scalar * bg_colour_initial.r
	g = corruption_scalar * bg_colour_final.g + uncorruption_scalar * bg_colour_initial.g
	b = corruption_scalar * bg_colour_final.b + uncorruption_scalar * bg_colour_initial.b
	b = corruption_scalar * bg_colour_final.b + uncorruption_scalar * bg_colour_initial.b
	environment_instance.get_environment().set_bg_color(Color(r,g,b))


func gameover():
#	print("scores: ",score_wecker,", ",score_time)
	get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue")._gameOver(score_wecker, round(score_time))
