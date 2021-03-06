extends Spatial

var settings_file = "user://settings.save"

export var corruption_scalar = 0.0

var player_instance
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

var music_max = -1.9
var audio_max = 3.8

var is_game_started = false
var level_index = -1
var score_time = 0.0
var score_wecker = 0

var M_wecker;
var assets_instance


func _init():
	
	load_settings()
	
	OS.window_fullscreen = Settings.is_fullscreen
	apply_audio_settings()
	
	var assets = load("res://Assets_1.tscn")
	assets_instance = assets.instance()
	self.add_child(assets_instance)


func load_settings():
	
	var file = File.new()
	if file.file_exists(settings_file):
		file.open(settings_file, File.READ)
		Settings.highscore_time_0 = file.get_var()
		Settings.highscore_wecker_0 = file.get_var()
		Settings.highscore_time_1 = file.get_var()
		Settings.highscore_wecker_1 = file.get_var()
		Settings.highscore_time_2 = file.get_var()
		Settings.highscore_wecker_2 = file.get_var()
		Settings.is_fullscreen = file.get_var()
		Settings.scalar_mouse_look = file.get_var()
		Settings.scalar_gamepad_look = file.get_var()
		Settings.scalar_music = file.get_var()
		Settings.scalar_audio = file.get_var()
		file.close()


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
	
	if Settings.restart_level > -1:
		self.get_node("Other/UI/MainMenu")._on_StartButton_pressed(Settings.restart_level)


func _toggle_fullscreen():
	
	Settings.is_fullscreen = not Settings.is_fullscreen
	OS.window_fullscreen = Settings.is_fullscreen
	if Settings.is_fullscreen:
		return "on"
	else:
		return "off"


func change_mouse_look(var increase):
	
	Settings.scalar_mouse_look += increase
	Settings.scalar_mouse_look = clamp(Settings.scalar_mouse_look, 0.0, 2.0)
	return String(round(100 * Settings.scalar_mouse_look)) + "%"

func change_gamepad_look(var increase):
	
	Settings.scalar_gamepad_look += increase
	Settings.scalar_gamepad_look = clamp(Settings.scalar_gamepad_look, 0.0, 2.0)
	return String(round(100 * Settings.scalar_gamepad_look)) + "%"

func change_music_volume(var increase):
	
	Settings.scalar_music += increase
	Settings.scalar_music = clamp(Settings.scalar_music, 0.0, 1.0)
	apply_audio_settings()
	return String(round(100 * Settings.scalar_music)) + "%"

func change_audio_volume(var increase):
	
	Settings.scalar_audio += increase
	Settings.scalar_audio = clamp(Settings.scalar_audio, 0.0, 1.0)
	apply_audio_settings()
	return String(round(100 * Settings.scalar_audio)) + "%"


func apply_audio_settings():
	
	var music = (1-Settings.scalar_music) * -72.0 + Settings.scalar_music * music_max
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), music)
	var audio = (1-Settings.scalar_audio) * -72.0 + Settings.scalar_audio * audio_max
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFXRev"), audio)


func onGameStart():
	
	var player = load("res://Player.tscn")
	player_instance = player.instance()
	player_instance.set_name("Player")
	add_child(player_instance)
	
	self.remove_child(assets_instance)
	if Settings.restart_level > -1:
		var level_name = "res://Assets_"+String(Settings.restart_level)+".tscn"
		var assets = load(level_name)
		assets_instance = assets.instance()
	else:
		print ("ERROR - Spielwelt.onGameStart: level index is ",Settings.restart_level)
	
	self.add_child(assets_instance)
	
	terrain_material = get_node("Assets/Boden/Terrain/Terrain_low")
	
	score_time = 0.0
	score_wecker = 0
	var WeckerSpawner = get_tree().get_root().get_node("Spielwelt/Assets/Spawner")
	WeckerSpawner.onGameStart(self)
	
	var player_spawnpoint = assets_instance.get_node("Player_Spawn")
	if player_spawnpoint:
		player_instance.translation = player_spawnpoint.translation
		player_instance.rotation.y = player_spawnpoint.rotation.y
		player_instance.camera.rotation.x = player_spawnpoint.rotation.x
	
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
	var vignette = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("Vignette")
	vignette.visible = false
	is_game_started = false
	
	score_time = round(score_time)
	if Settings.restart_level == 0:
		if score_time >= Settings.highscore_time_0:
			Settings.highscore_time_0 = score_time
		if score_wecker >= Settings.highscore_wecker_0:
			Settings.highscore_wecker_0 = score_wecker
		save_settings()
		get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue").gameOver(score_wecker, score_time, Settings.highscore_wecker_0, Settings.highscore_time_0)
	elif Settings.restart_level == 1:
		if score_time >= Settings.highscore_time_1:
			Settings.highscore_time_1 = score_time
		if score_wecker >= Settings.highscore_wecker_1:
			Settings.highscore_wecker_1 = score_wecker
		save_settings()
		get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue").gameOver(score_wecker, score_time, Settings.highscore_wecker_1, Settings.highscore_time_1)
	elif Settings.restart_level == 2:
		if score_time >= Settings.highscore_time_2:
			Settings.highscore_time_2 = score_time
		if score_wecker >= Settings.highscore_wecker_2:
			Settings.highscore_wecker_2 = score_wecker
		save_settings()
		get_tree().get_root().get_node("Spielwelt/Other/UI/GameOverMenue").gameOver(score_wecker, score_time, Settings.highscore_wecker_2, Settings.highscore_time_2)
	
	


func restart():

	get_tree().change_scene("res://Spielwelt.tscn")
	get_tree().paused = false


func close_application():
	
	save_settings()
	get_tree().quit()


func save_settings():

	var file = File.new()
	file.open(settings_file, File.WRITE)
	file.store_var(Settings.highscore_time_0)
	file.store_var(Settings.highscore_wecker_0)
	file.store_var(Settings.highscore_time_1)
	file.store_var(Settings.highscore_wecker_1)
	file.store_var(Settings.highscore_time_2)
	file.store_var(Settings.highscore_wecker_2)
	file.store_var(Settings.is_fullscreen)
	file.store_var(Settings.scalar_mouse_look)
	file.store_var(Settings.scalar_gamepad_look)
	file.store_var(Settings.scalar_music)
	file.store_var(Settings.scalar_audio)
	file.close()

