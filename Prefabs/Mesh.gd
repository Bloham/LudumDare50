extends MeshInstance

export var is_visible = true;
export var is_fading = false

var Mat = self
var scalar_fading = 0
var scalar_fadingSpeed = .1


func _ready():
	
	Mat.set_material_override(Mat.get_active_material(0).duplicate())
	
	if(is_visible):
		Mat.get_active_material(0).set_shader_param("ScalarInput", -1)
	else:
		Mat.get_active_material(0).set_shader_param("ScalarInput", 1)
		scalar_fadingSpeed *= -1
	
	scalar_fading = Mat.get_active_material(0).get_shader_param("ScalarInput")


func _process(delta):
	
	if (is_fading):
		scalar_fading = clamp(scalar_fading + delta * scalar_fadingSpeed, -1, 1)
		Mat.get_active_material(0).set_shader_param("ScalarInput", scalar_fading)
