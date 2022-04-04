extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var corruption_scalar = 0.0

func _ready():
	var lightning = load("res://DirectionalLight.tscn")
	var lightning_instance = lightning.instance()
	lightning_instance.set_name("DirectionalLight")
	
	var envorment = load("res://WorldEnvironment.tscn")
	var envorment_instance = envorment.instance()
	envorment_instance.set_name("WorldEnviorment")
	
	add_child(lightning_instance)
	add_child(envorment_instance)
	

func _init():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
