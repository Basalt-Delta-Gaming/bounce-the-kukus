extends Node2D

const KUKU = preload("res://szenes/kuku.tscn")
const ITEM = preload("res://szenes/item.tscn")
const BOUNCY = preload("res://szenes/bouncy.tscn")

const itemSpawnChance: int = 10

@onready var bouncy_scope: Node2D = $BouncyScope
@onready var item_scope: Node2D = $ItemScope
@onready var death_floor: Area2D = $Area2D
@onready var level_up_timer: Timer = $LevelUpTimer

func _ready() -> void:
	Global.game_over.connect(game_over) 
	Global.level_up.connect(level_up) 

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("mouse_left"):  # Check if the left mouse button was just pressed
		var mouse_position = get_mouse_position()
		summon_kuku(mouse_position)
	
	#if Input.is_action_just_pressed("mouse_right"):  # Check if the left mouse button was just pressed

func get_mouse_position() -> Vector2:
	return get_viewport().get_mouse_position()
	
func summon_kuku(pos: Vector2):
	var bouncy = KUKU.instantiate()
	bouncy.position = pos
	bouncy_scope.add_child(bouncy)

func game_over():
	for bouncy in bouncy_scope.get_children():
		bouncy.queue_free()  # Remove safely
	for item in item_scope.get_children():
		item.queue_free()  # Remove safely

func level_up():
	game_over()
	level_up_timer.start()

func _on_area_2d_body_entered(body: Node2D) -> void:
	
	if body is Kuku:
		body.queue_free()
		Global.hearts -= 1
		if (Global.hearts <= 0):
			return
		
		var bouncy = KUKU.instantiate()
		bouncy_scope.call_deferred("add_child", bouncy)
	
	if body is Item:
		body.queue_free()

func _on_item_top_spawner_body_entered(body: Node2D) -> void:
	if body is Kuku:
		var chance = randi_range(1 ,itemSpawnChance)
		if chance == 1:
			var pos = body.global_position
			var item = ITEM.instantiate()
			item.make_ready(pos)
			item_scope.call_deferred("add_child",item)
		
func _on_level_up_timer_timeout() -> void:
	for blank in range(Global.level):
		summon_kuku(Vector2(200, 270))
