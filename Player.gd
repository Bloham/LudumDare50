extends KinematicBody

var velocity = Vector3.ZERO
var speed = 10
var gravity = 2

export var walk_speed = 8
export var run_speed = 20
export var jump_strength := 20.0

#var camera rotation
onready var player_camera = $Camera
var spin = 0.1
export var mouse_sensitivity = 5

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta):
	player_camera.rotation_degrees.y = 180
	player_camera.rotation_degrees.z = 0
	
	if not is_on_floor():
		velocity.y += -gravity
		#print("falling")
	
	movement()
	velocity = move_and_slide(velocity, Vector3.ZERO)

func movement():
	var dir = Vector3.ZERO
	var vel_y = velocity.y
	
	velocity = Vector3.ZERO
	
	#move Forward and Backwards
	if Input.is_action_pressed("ui_up"):
		dir += transform.basis.z
		_play_footsteps()
	elif Input.is_action_pressed("ui_down"):
		dir -= transform.basis.z
		_play_footsteps()
	
	#move sideways
	if Input.is_action_pressed("ui_left"):
		dir += transform.basis.x
		_play_footsteps()
	elif Input.is_action_pressed("ui_right"):
		dir -= transform.basis.x
		_play_footsteps()
	
	#running
	if Input.is_action_pressed("run"):
		speed = run_speed
	else:
		speed = walk_speed
	
	#Jumping
	if is_on_floor() and Input.is_action_just_pressed("ui_accept"):
		velocity.y += jump_strength
		print("Jump")
	
	velocity = dir.normalized() * speed
	velocity.y = vel_y
	
	if velocity == Vector3(0,-1,0):
		$AudioStreamPlayer.stop()
	
	
func _play_footsteps():
	if  !$AudioStreamPlayer.playing:
		$AudioStreamPlayer.stream = load("res://Audio/SFX/sfx_footsteps_walk.wav")
		$AudioStreamPlayer.pitch_scale = 0.66
		$AudioStreamPlayer.play()
		
	
func _input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		rotate_y(lerp(0, -spin, event.relative.x*(mouse_sensitivity * 0.01)))
		player_camera.rotate_x(lerp(0, spin, event.relative.y*(mouse_sensitivity * 0.01)))
		
		#clamp rotation
		var curr_rot = player_camera.rotation_degrees
		curr_rot.x = clamp(curr_rot.x, -60, 60)
		player_camera.rotation_degrees = curr_rot
	
	#quit game with ESC
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
