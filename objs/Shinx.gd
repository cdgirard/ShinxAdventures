extends KinematicBody2D

var camera

var run_speed = 50
var jump_speed = -750
var swatTimer = 0
var swat = false
var gravity = Vector2(0,30)
var facing_right = true
var velocity = Vector2()
var pawAngle = 0
var pawTrans = Vector2(0,0)
var maxDistance = 50
var maxAngle = 100
var minAngle = 10

func _ready() :
	camera = get_node("Camera2D")

func _input(event):
	if !swat and event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		var arm = get_node("Arm")
		pawAngle = -(arm.get_angle_to(get_global_mouse_position())+PI/2)
		arm.rotate(arm.get_angle_to(get_global_mouse_position())+PI/2)
		print("Angle:",-pawAngle)
		
		var viewport = get_viewport()
		var modX = event.position.x + Shinx.camera.get_camera_position().x - viewport.size.x/2
		var modY = event.position.y + Shinx.camera.get_camera_position().y - viewport.size.y/2
		print("arm: ",modX," : ",modY)
		var offset = Vector2((modX - (position.x + arm.position.x)),(modY - (position.y + arm.position.y)))
		print("Offset: ",offset)
		offset = offset.clamped(maxDistance)
		pawTrans -= offset;
		#arm.translate(offset)
		#arm.move_slide(offset)
		arm.move_and_slide(offset)
		swatTimer = 1
		swat = true

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_pressed('ui_up')
	
	#if is_on_floor() and jump:
	#	velocity.y = jump_speed
		
	if right:
		velocity.x += run_speed
		move_and_slide(velocity)
	if left:
		velocity.x -= run_speed
		move_and_slide(velocity)
	
	#if Input.is_mouse_button_pressed(BUTTON_LEFT) :
	#	print("clicked")

func _process(delta):
	if swat :
		var arm = get_node("Arm")
		swatTimer -= delta
		arm.move_and_slide(-pawTrans)
		if swatTimer <= 0 :
			swat = false
			
			#arm.translate(pawTrans)
			arm.rotate(pawAngle)
			pawTrans = Vector2(0,0)

func _physics_process(delta):
	if !is_on_floor() :
		move_and_slide(gravity)
	get_input()
	
	
#func _process(delta):
	#var r = arm.global_rotation_degrees
	#if (r > 90 or r < -90) and facing_right:
	#	flip()
	#if (r < 90 and r > -90) and !facing_right:
	#	flip()

func flip():
	$Sprite.scale.x *= -1
	facing_right = !facing_right
	$Arm.scale.y *= -1

