extends RigidBody

func _ready():
	$AnimationPlayer.play("CollisionShapeSize")

func _on_Area_body_entered(body):
	queue_free()
