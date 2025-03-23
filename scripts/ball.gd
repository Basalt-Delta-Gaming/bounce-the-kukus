extends RigidBody2D

@onready var player: CharacterBody2D = $"../Player"
@onready var camera_2d: Camera2D = $"../Camera2D"

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("mouse_right"):
		replace_with_charBody()
		return

func _physics_process(_delta: float) -> void:
	camera_2d.global_position = global_position.lerp(global_position, 0.1)

func replace_with_charBody():
	
	var player_pos = global_position
	var player_velocity = linear_velocity
	
	player.global_position = player_pos
	player.velocity = player_velocity 
	
	process_mode = Node.PROCESS_MODE_DISABLED
	visible = false
	player.process_mode = Node.PROCESS_MODE_INHERIT
	player.visible = true
