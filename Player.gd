extends KinematicBody

export var speed := 7.0
export var jump_strength := 20.0
export var gravity := 50.0

const MOUSE_SENSITIVITY = 0.2

onready var look_pivot: Spatial = $LookPivot

var _velocity := Vector3.ZERO
var _snap_vector := Vector3.DOWN

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED) #disable mouse zeiger

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-1 * event.relative.x * MOUSE_SENSITIVITY))
		look_pivot.rotate_x(deg2rad(event.relative.y * MOUSE_SENSITIVITY))

func _physics_process(delta: float) -> void:
	var move_direction := Vector3.ZERO
	move_direction.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	move_direction.z = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	
	_velocity.x = move_direction.x * speed
	_velocity.z = move_direction.z * speed
	_velocity.y -= gravity * delta
	
	var just_landed := is_on_floor() and _snap_vector == Vector3.ZERO
	var is_jumping := is_on_floor() and Input.is_action_just_pressed("ui_accept")
	if is_jumping:
		_velocity.y = jump_strength
		_snap_vector = Vector3.ZERO
	elif just_landed:
		_snap_vector = Vector3.DOWN
	_velocity = move_and_slide_with_snap(_velocity, _snap_vector, Vector3.UP, true)

