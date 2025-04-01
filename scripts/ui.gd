extends Control

@onready var ui_start: NinePatchRect = $UI_Start
@onready var ui_levels: NinePatchRect = $UI_Levels

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("escape") and ui_levels.visible == true:
		ui_start.visible = true
		ui_levels.visible = false

func _on_button_play_pressed() -> void:
	ui_start.visible = false
	ui_levels.visible = true

func _on_button_settings_pressed() -> void:
	pass # Replace with function body.


func _on_button_quit_pressed() -> void:
	pass # Replace with function body.
