extends Spatial

export var is_restart_version = false
export var restart_level_index = -1

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

var is_fullscreen = true
var is_game_started = false
var level_index = -1
var score_time = 0.0
var score_wecker = 0

var M_wecker;
var assets_instance


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
	
	var weckerScene = preload("res://Wecker.tscn")
	var wecker = weckerScene.instance()
	M_wecker = wecker._get_shaderMaterial()
	
	if is_restart_version:
		self.get_node("Other/UI/MainMenu")._on_StartButton_pressed(restart_level_index)


func _init():
	
	OS.window_fullscreen = is_fullscreen
	var assets = load("res://Assets_1.tscn")
	assets_instance = assets.instance()
	self.add_child(assets_instance)


func _toggle_fullscreen():
	
	is_fullscreen = !is_fullscreen
	OS.window_fullscreen = is_fullscreen


func onGameStart(var _level_index):
	
	if _level_index > -1:
		level_index = _level_index
	
	self.remove_child(assets_instance)
	if level_index == 0:
		var assets = load("res://Assets_1.tscn")
		assets_instance = assets.instance()
	else:
		var assets = load("res://Assets_2.tscn")
		assets_instance = assets.instance()
		
	self.add_child(assets_instance)
	
	terrain_material = get_node("Assets/Boden/Terrain/Terrain_low")
	
	score_time = 0.0
	score_wecker = 0
	var WeckerSpawner = get_tree().get_root().get_node("Spielwelt/Assets/Spawner")
	WeckerSpawner.onGameStart(self)
	
	is_game_started = true


func _process(delta):
	
	if is_game_started:
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
	
	is_game_started = false
#	print("scores: ",score_wecker,", ",score_time)
	get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue")._gameOver(score_wecker, round(score_time))
