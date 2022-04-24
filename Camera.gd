extends Node


var cameraStartPosition


# Called when the node enters the scene tree for the first time.
func _ready():
	cameraStartPosition = $MenueCamera.translation

func _on_Timer_timeout():
	$MenueCamera.translation = cameraStartPosition
