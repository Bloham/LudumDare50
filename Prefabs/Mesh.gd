extends MeshInstance


export var is_visible = true;
var Mat = self

var is_fading = false
var scalar_fading = 0
var scalar_fadingSpeed = .1



# Called when the node enters the scene tree for the first time.
func _ready():
	if(is_visible):
		Mat.get_active_material(0).set_shader_param("ScalarInput", -1)
	else:
		Mat.get_active_material(0).set_shader_param("ScalarInput", 1)
		scalar_fadingSpeed *= -1
	scalar_fading = Mat.get_active_material(0).get_shader_param("ScalarInput")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_fading):
		scalar_fading += delta * scalar_fadingSpeed
		Mat.get_active_material(0).set_shader_param("ScalarInput", scalar_fading)
		print (Mat.get_active_material(0).get_shader_param("ScalarInput"))
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_F and !is_fading:
			print ("F key was pressed- fadeable objects should fade now")
			is_fading = true
