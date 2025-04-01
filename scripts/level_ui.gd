extends Control

@onready var label_hearts: Label = $LabelHearts
@onready var label_bounces: Label = $LabelBounces

func _ready():
	Global.hearts_updated.connect(update_hearts) 
	Global.bounces_updated.connect(update_bounces)  
	
func update_hearts(new_hearts: int):
	label_hearts.text = str(new_hearts)

func update_bounces(new_bounces: int):
	label_bounces.text = str(new_bounces)
