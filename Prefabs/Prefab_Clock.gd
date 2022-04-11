extends Spatial


onready var aniPlayer = $AnimationPlayer


func _ready():
	aniPlayer.play("Wecker")
