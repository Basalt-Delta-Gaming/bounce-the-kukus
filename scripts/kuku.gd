extends RigidBody2D
	
class_name Kuku

var initial_speed = 200  # Set a desired speed
var highest_speed = 400
var lowest_rotation = 0.5
var highest_rotation = 2

var speed: int = 200
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	make_ready()
	
func make_ready(): 
	speed = randi_range(200, 400)
	var initial_direction = Vector2.DOWN.rotated(randf() * PI)  # Random direction
	linear_velocity = initial_direction * speed  # Apply initial velocity
	set_global_position(Vector2(200, 200))
	animation_player.speed_scale = randf_range(lowest_rotation, highest_rotation)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	if state.linear_velocity.length() > 0:  # Ensure movement direction is valid
		var movement_direction = state.linear_velocity.normalized()
		state.linear_velocity = movement_direction * speed
