extends Camera2D

@onready var queen = $".."

func _process(delta):
	global_position = queen.global_position
