extends KinematicBody


#Physics
export var walkSpeed = 16
export var runSpeed = 30
export var jumpForce = 20

#Footstep Sound
export var audioWalkPitch = 0.66
export var audioRunPitch = 1

var gravity = 40
var moveSpeed = 18

#Camera
var minLookAngle = -90
var maxLookAngle = 90
var lookSensitivity = 50

#Vectors
var vel = Vector3()
var mouseDelta = Vector2()

#Conponents
onready var camera = $Camera
onready var audioPlayerFootsteps = $Footsteps
onready var audioPlayerJump = $Jump

func _ready():
	#hide and lock mouse
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#set up steps sound


func _physics_process(delta):
	
	#reset x and z velocity
	vel.x = 0
	vel.z = 0
	
	var input = Vector2()
	
	#Movement Inputs
	if Input.is_action_pressed("ui_up"):
		input.y -= 1
	if Input.is_action_pressed("ui_down"):
		input.y += 1
	if Input.is_action_pressed("ui_left"):
		input.x -= 1
	if Input.is_action_pressed("ui_right"):
		input.x += 1
		
	input = input.normalized()
	
	#get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
	#set Velocity
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	#Gravity
	vel.y -= gravity * delta
	
	#move the player
	vel = move_and_slide(vel, Vector3.UP)
	
	#jumping
	if Input.is_action_pressed("ui_accept") and is_on_floor():
		vel.y = jumpForce
		audioPlayerJump.play()
	
	#play fotsteps
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right") and is_on_floor() == true:
		_playFootsteps()
	
	#play runing fotsteps and speed
	if Input.is_action_pressed("run"):
		audioPlayerFootsteps.pitch_scale = audioRunPitch
		moveSpeed = runSpeed
	else:
		audioPlayerFootsteps.pitch_scale = audioWalkPitch
		moveSpeed = walkSpeed
	
	if input == Vector2.ZERO:
		audioPlayerFootsteps.stop()
	if is_on_floor() == false:
		audioPlayerFootsteps.stop()


func _playFootsteps():
	if audioPlayerFootsteps.playing == false and is_on_floor() == true:
		audioPlayerFootsteps.play()

func _process(delta):
	#rotate camera along the x axis
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * delta
	
	#clamp camera x axis
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	#rotate camera along y axis
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * delta
	
	#reset the mouse delta vector
	mouseDelta = Vector2()

func _input(event):
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	
	#quit with ESC
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()
	
