extends Node

onready var camera = $MenueCamera
onready var targetStart = $TargetStart


func _ready():
	pass # Replace with function body.



func _on_CameraTimer_timeout():
	camera.transform = targetStart.transform
	pass # Replace with function body.
