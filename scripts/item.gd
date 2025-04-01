extends CharacterBody2D

class_name Item

var speed = 200.0

func _ready() -> void:
	pass
	
func make_ready(pos:Vector2): 
	position = pos
	velocity = Vector2(0, speed)

func _physics_process(delta: float) -> void:
	move_and_slide()
