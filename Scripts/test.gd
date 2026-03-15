extends Node2D

@onready var queen = $Queen

func _input(event):

	if queen.selected:

		if event is InputEventScreenTouch and event.pressed:
			queen.target_position = event.position
			queen.moving = true
			queen.selected = false

		if event is InputEventMouseButton and event.pressed:
			queen.target_position = event.position
			queen.moving = true
			queen.selected = false
