extends CharacterBody2D

@export var walk_speed = 250
@export_range(0,1) var acceleration = 0.5
@export_range(0,1) var decelaration = 0.5
@export var jump_force = -600
@export_range(0,1) var deceleration_on_jump_release = 0.5

@export var dash_speed = 1500.0
@export var dash_max_distance = 200
@export var dash_curve: Curve
@export var dash_cooldown = 1

var is_dashing = false
var dash_start_position = Vector2(0,0)
var dash_direction = Vector2(0,0)
var dash_timer = 0

@onready var ball: RigidBody2D = $"../Ball"
@onready var camera_2d: Camera2D = $"../Camera2D"

func _physics_process(delta: float) -> void:
	# Add the gravity.
	camera_2d.global_position = global_position.lerp(global_position, 0.1)
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("mouse_left"):
		replace_with_rigidbody()
		return
		
	# Handle jump.
	if Input.is_action_pressed("input_space") and is_on_floor():
		velocity.y = jump_force
	if Input.is_action_just_released("input_space") and velocity.y < 0:
		velocity.y *= deceleration_on_jump_release

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = move_toward( velocity.x, direction * walk_speed ,walk_speed * acceleration) 
	else:
		velocity.x = move_toward(velocity.x, 0, walk_speed * decelaration)

	if Input.is_action_just_pressed("input_f") and velocity and not is_dashing and dash_timer <= 0:
		is_dashing = true
		dash_start_position = position
		dash_timer = dash_cooldown

	if is_dashing:
		var current_distance = position.distance_to(dash_start_position)
		if current_distance >= dash_max_distance or is_on_wall() or is_on_ceiling():
			is_dashing = false
			velocity = Vector2(0,0)
		else:
			var current_dir = velocity.normalized()
			velocity = current_dir * dash_speed * dash_curve.sample(current_distance / dash_max_distance )
	
	if dash_timer > 0:
		dash_timer -= delta

	move_and_slide()

func replace_with_rigidbody():
	
	var player_pos = global_position
	var player_velocity = velocity  # CharacterBody2D has .velocity in Godot 4
	
	# Set position and velocity
	ball.global_position = player_pos
	ball.linear_velocity = player_velocity  # RigidBody2D uses linear_velocity
	
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	ball.process_mode = Node.PROCESS_MODE_INHERIT
	ball.visible = true
	# Add to scene and remove the old player
	#camera_2d.reparent(rigidbody_instance, true)
