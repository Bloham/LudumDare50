extends Node


export var is_visible = true;
var Mat

var is_fading = false
var scalar_fading = 0
var scalar_fadingSpeed = .1



# Called when the node enters the scene tree for the first time.
func _ready():
	Mat = self.get_material()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	scalar_fading += clamp(is_fading * delta * scalar_fadingSpeed, -1, 1)
	Mat.set_shader_param("input",scalar_fading)
	

func Fade():
	if !is_fading:
		is_fading = true
