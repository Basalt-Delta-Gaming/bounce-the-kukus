extends CharacterBody2D

class_name Player

@export var walk_speed: int = 200
@export var acceleration: float = 0.5
@export var decelaration: float = 0.5

var facing_left: bool = true

@onready var sprite_2d: Sprite2D = $Sprite2D
	
func _physics_process(delta: float) -> void:

	#if not is_on_floor():
	#	velocity += get_gravity() * delta

	var direction := Input.get_axis("input_left", "input_right")
	if direction:
		velocity.x = move_toward( 
			velocity.x, 
			direction * walk_speed, 
			walk_speed * acceleration
		) 
		if((direction == -1) != (!facing_left)):
			facing_left = !facing_left
			sprite_2d.scale.y *= -1
	else:
		velocity.x = move_toward(velocity.x, 0,walk_speed * decelaration)
	
	move_and_slide()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is Kuku:
		Global.bounces_total += 1
	if body is Item:
		body.queue_free()
