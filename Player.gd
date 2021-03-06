extends KinematicBody

#Physics
export var walk_speed = 28
#export var runSpeed = 30
export var jump_force = 37.5
export var dash_force = 144
export var corruption_Bonus = 6
export var grounded_duration = 0.5
export var dash_duration = 0.25
#export var dash_cooldown = 2.0
export var dash_feedback_strength = 14.2

#Footstep Sound
#export var audioWalkPitch = 0.66
#export var audioRunPitch = 1

var gravity = 40
var moveSpeed = 18
var grounded_time = 0.0
var dash_time = 0.0
var can_dash = true
var is_grounded = false
var is_jumping = false

#Camera
var minLookAngle = -90
var maxLookAngle = 90
var lookSensitivity = 12.5
var pad_lookSensitivity = 175.0

#Vectors
var vel = Vector3()
var dash_vel = Vector3()
var mouseDelta = Vector2()
var padDelta = Vector2()

var is_dashing = false


#Conponents
onready var camera = $Camera
onready var audioPlayerFootsteps = $Footsteps
onready var audioPlayerJump = $Jump
onready var audioPlayerDash = $Dash
onready var camera_fov_base = camera.fov

var uiNode
var corruption_Scalar



func _ready():
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	uiNode = get_tree().get_root().get_node("Spielwelt/Other/UI/PauseMenue")
	corruption_Scalar = get_tree().get_root().get_node("Spielwelt").get("corruption_scalar")
	
	var vp_size = get_viewport().size
	print (" > viewport: ",vp_size.x,", ",vp_size.y)
	var w_size = OS.get_window_size()
	print (" > window: ",w_size.x,", ",w_size.y)
	
	$Vignette/VignetteUP.rect_position = Vector2(0, -1440)
	$Vignette/VignetteDOWN.rect_position = Vector2(0, 1440)


func _physics_process(delta):
	
	var coruption_Movement_Bonus = 1 + (corruption_Bonus * corruption_Scalar)
	var input = Vector2()
#	print(grounded_time)
	
	dash_time += delta
	if is_on_floor():
		is_jumping = false
		can_dash = true
		grounded_time = grounded_duration
	else:
		grounded_time -= delta
	is_grounded = grounded_time > 0
	
	if is_dashing:
		vel.x = dash_force * coruption_Movement_Bonus * dash_vel.x
		vel.y = dash_force * coruption_Movement_Bonus * dash_vel.y
		vel.z = dash_force * coruption_Movement_Bonus * dash_vel.z
		if audioPlayerDash.playing == false:
			audioPlayerDash.play()
		if dash_time > dash_duration:
			is_dashing = false
			dash_time = 0.0
			camera.fov = camera_fov_base
		else:
			var extra_fov =  dash_feedback_strength * -1.0 * sin(PI * dash_time/dash_duration)
			camera.fov = camera_fov_base + extra_fov
	else:
		
		#reset x and z velocity
		vel.x = 0
		vel.z = 0
		
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
	#	if Input.is_action_pressed("run") or Input.is_action_pressed("gamepad_sprint"):
	#		audioPlayerFootsteps.pitch_scale = audioRunPitch
	#		moveSpeed = runSpeed
	#	else:
	#		audioPlayerFootsteps.pitch_scale = audioWalkPitch
	#		moveSpeed = walk_speed

		if not is_dashing and can_dash and grounded_time < 0.45 and (Input.is_action_just_pressed("run") or Input.is_action_just_pressed("gamepad_sprint")):
#			(dash_time > dash_cooldown)
			is_dashing = true
			can_dash = false
			dash_time = 0.0
			dash_vel = -forward
			vel = dash_force * coruption_Movement_Bonus * dash_vel
		else:
			#set Velocity
			moveSpeed = walk_speed * coruption_Movement_Bonus
			vel.x = relativeDir.x * moveSpeed
			vel.z = relativeDir.z * moveSpeed
			
			#Gravity
			vel.y -= 0.018* gravity
		
		#move the player
		if is_grounded and not is_jumping:
			if Input.is_action_pressed("ui_accept") or Input.is_action_pressed("gamepad_jump"):
				is_jumping = true
				vel.y = jump_force * coruption_Movement_Bonus
				audioPlayerJump.play()
	
	vel = move_and_slide(vel, Vector3.UP)
	
	#play fotsteps
	if Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up") or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		_playFootsteps()
	
	if input == Vector2.ZERO:
		audioPlayerFootsteps.stop()
	if is_grounded == false:
		audioPlayerFootsteps.stop()
		
	if Input.is_action_pressed("ui_cancel"):
		uiNode._activatePause()
		var vignette = get_tree().get_root().get_node("Spielwelt").get_node("Other").get_node("UI").get_node("Vignette")
		vignette.visible = false
		$Vignette.visible = false
	
#	if Input.is_key_pressed(KEY_G):
#		_playAnimation()


func _playFootsteps():
	
	if audioPlayerFootsteps.playing == false and is_grounded == true:
		audioPlayerFootsteps.play()


func _process(delta):
	
	var pad_aim = Input.get_vector("gamepad_aim_left", "gamepad_aim_right", "gamepad_aim_up", "gamepad_aim_down")
	pad_aim *= pad_lookSensitivity * Settings.scalar_gamepad_look * delta
	
	#rotate camera
	rotation_degrees.y -= mouseDelta.x * lookSensitivity * Settings.scalar_mouse_look * delta + pad_aim.x
	camera.rotation_degrees.x -= mouseDelta.y * lookSensitivity * Settings.scalar_mouse_look * delta + pad_aim.y
	camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, minLookAngle, maxLookAngle)
	
	#reset the mouse delta vector
	mouseDelta = Vector2()


func _input(event):
	
	if event is InputEventMouseMotion:
		mouseDelta += event.relative

func _playAnimation():
	
	$Vignette.visible = true
	var tween = get_node("Tween")
	tween.interpolate_property($Vignette/VignetteDOWN, "rect_position",Vector2(0, 1440), Vector2(0, 0), 15,Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()
	tween.interpolate_property($Vignette/VignetteUP, "rect_position",Vector2(0, -1440), Vector2(0 , 0), 15,Tween.TRANS_BOUNCE, Tween.EASE_IN_OUT)
	tween.start()
	#$AnimationPlayer.play("EyesCloseEnd")

