extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var corruption_scalar = 0.0

var terrain_material

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
