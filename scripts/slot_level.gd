extends Button

@export var number: int
@onready var label: Label = $Label

func _ready() -> void:
	label.text = str(number)
