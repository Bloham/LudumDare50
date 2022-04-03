extends MeshInstance


export var is_visible = true;
var Mat = self

var is_fading = false
var scalar_fading = 0
var scalar_fadingSpeed = .1



func _ready():
	var rng = RandomNumberGenerator.new();
	var xfactor = round(get_parent().translation.x + get_parent() .translation.y + get_parent() .translation.z)
	rng.set_seed(xfactor)
	var xscalar = rng.randf_range(.0001, 5)
	scalar_fadingSpeed *= xscalar
	
	Mat.set_material_override(Mat.get_active_material(0).duplicate())
	
	if(is_visible):
		Mat.get_active_material(0).set_shader_param("ScalarInput", -1)
	else:
		Mat.get_active_material(0).set_shader_param("ScalarInput", 1)
		scalar_fadingSpeed *= -1
	scalar_fading = Mat.get_active_material(0).get_shader_param("ScalarInput")
	print (scalar_fading)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_fading):
		scalar_fading = clamp(scalar_fading + delta * scalar_fadingSpeed, -1, 1)
		Mat.get_active_material(0).set_shader_param("ScalarInput", scalar_fading)
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_F and !is_fading:
			print ("F key was pressed- fadeable objects should fade now")
			is_fading = true
