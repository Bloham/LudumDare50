extends RigidBody

func _ready():
	$AnimationPlayer.play("CollisionShapeSize")
	
	
func _on_DestroyAlarm_body_entered(body):
	pass
