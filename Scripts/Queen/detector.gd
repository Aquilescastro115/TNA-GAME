extends Area2D

@onready var queen = get_parent()

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventScreenTouch and event.pressed:
		queen.selected = true
	if event is InputEventMouseButton and event.pressed:
		queen.selected = true
