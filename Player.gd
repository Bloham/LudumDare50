extends KinematicBody

#Physics
export var walkSpeed = 1
export var runSpeed = 2
export var jumpForce = 3

#Footstep Sound
export var audioWalkPitch = 0.66
export var audioRunPitch = 1

var gravity = 40
var moveSpeed = 18

#Camera
var minLookAngle = -90
var maxLookAngle = 90
var lookSensitivity = 50
var pad_lookSensitivity = 120.0

#Vectors
var vel = Vector3()
var mouseDelta = Vector2()
var padDelta = Vector2()

#Conponents
onready var camera = $Camera
onready var audioPlayerFootsteps = $Footsteps
onready var audioPlayerJump = $Jump

var uiNode


func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	uiNode = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("PauseMenue")


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
		
	var pad_move = Input.get_vector("gamepad_move_left", "gamepad_move_right", "gamepad_move_forward", "gamepad_move_back")
	input += pad_move
	
	input = input.normalized()
	
	#get the forward and right directions
	var forward = global_transform.basis.z
	var right = global_transform.basis.x
	
	var relativeDir = (forward * input.y + right * input.x)
	
	#play runing fotsteps and speed
	if Input.is_action_pressed("run") or Input.is_action_pressed("gamepad_sprint"):
		audioPlayerFootsteps.pitch_scale = audioRunPitch
		moveSpeed = runSpeed
	else:
		audioPlayerFootsteps.pitch_scale = audioWalkPitch
		moveSpeed = walkSpeed
	
	#set Velocity
	vel.x = relativeDir.x * moveSpeed
	vel.z = relativeDir.z * moveSpeed
	
	#Gravity
	vel.y -= 0.018* gravity
	
	#move the player
	if is_on_floor():
		if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("gamepad_jump"):
			vel.y = jumpForce
			audioPlayerJump.play()
	vel = move_and_slide(vel, Vector3.UP)
	
	#play fotsteps
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		_playFootsteps()
	
	if input == Vector2.ZERO:
		audioPlayerFootsteps.stop()
	if is_on_floor() == false:
		audioPlayerFootsteps.stop()


func _playFootsteps():
	
	if audioPlayerFootsteps.playing == false and is_on_floor() == true:
		audioPlayerFootsteps.play()


func _process(delta):
	
	var pad_aim = Input.get_vector("gamepad_aim_left", "gamepad_aim_right", "gamepad_aim_up", "gamepad_aim_down")
	pad_aim *= pad_lookSensitivity * delta
	
	#rotate camera along the x axis
	camera.rotation_degrees.x -= (mouseDelta.y + pad_aim.y) * lookSensitivity * delta
	
	#clamp camera x axis
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	#rotate camera along y axis
	rotation_degrees.y -= (mouseDelta.x + pad_aim.x) * lookSensitivity * delta
	
	#reset the mouse delta vector
	mouseDelta = Vector2()


func _input(event):
	
	if event is InputEventMouseMotion:
		mouseDelta = event.relative
	
	#quit with ESC
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			uiNode._activatePause()
#			var pauseMenueResource = load("res://PauseMenue.tscn")
#			var pauseMenue = pauseMenueResource.instance()
#			uiNode.add_child(pauseMenue)
	
