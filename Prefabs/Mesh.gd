extends MeshInstance


export var is_visible = true;
var Mat = self

var is_fading = false
var scalar_fading = 0
var scalar_fadingSpeed = .1



# Called when the node enters the scene tree for the first time.
#func _ready():
#	Mat = self.get_material()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (is_fading):
#		scalar_fading += clamp(delta * scalar_fadingSpeed, -1, 1)
#		Mat.get_active_material(0).set_shader_param("input", 1)
		print (Mat.get_active_material(0).get_shader_param("input"))
	
func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_F:
			print ("F key was pressed- fadable objects should fade now")
			Fade()

func Fade():
	if !is_fading:
		is_fading = true
