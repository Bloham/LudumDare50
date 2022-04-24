extends ColorRect

var Mat

onready var spiel = get_tree().get_root().get_node("Spielwelt")


func _ready():
	
	self.material = self.material.duplicate()
	Mat = self.material


func _process(delta):
	
	self.material.set_shader_param("multiplier", 1.0 - spiel.corruption_scalar)
	self.material.set_shader_param("softness", 1.0 - 0.3 * spiel.corruption_scalar)
