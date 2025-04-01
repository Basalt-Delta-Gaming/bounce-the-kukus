extends Node

signal game_over
signal level_up
signal bounces_updated
signal hearts_updated

const heart_multiplyer: int = 10
const level_multiplyer: int = 10

var level: int = 1

var bounces_level: int = 0
var bounces_total: int = 0:
	set(value):
		bounces_total = value
		bounces_level += 1 # update seperate level bounces
		bounces_updated.emit(bounces_total)  # Emit signal when score changes
		add_heart()
		if (value >= level * level_multiplyer):
			level_up.emit()
			level += 1

var hearts: int = 10:
	set(value):
		hearts = value
		hearts_updated.emit(hearts)  # Emit signal when score changes
		if value <= 0:
			game_over.emit()
	
func add_heart():
	if (hearts < level * heart_multiplyer):
		hearts += 1
