extends Node2D

@onready var queen = $Queen
@onready var food_label = $UI/HBoxContainer/FoodVar
@onready var cap_label = $UI/HBoxContainer/CapVar
func _ready():
	update_food()

func _input(event):

	if not queen.selected:
		return

	if event is InputEventScreenTouch and event.pressed:
		handle_click(event.position)

	if event is InputEventMouseButton and event.pressed:
		handle_click(event.position)


func handle_click(pos):

	for bush in get_tree().get_nodes_in_group("food"):

		var sprite = bush.get_node("Bush")
		var size = sprite.texture.get_size() * sprite.scale

		var rect = Rect2(bush.global_position, size)

		if rect.has_point(pos):

			queen.target_position = bush.global_position + size / 2
			queen.target_bush = bush
			queen.moving = true
			queen.selected = false
			return

	queen.target_position = pos
	queen.target_bush = null
	queen.moving = true
	queen.selected = false

func update_food():
	food_label.text = str(GameData.food)

func update_cap():
	cap_label.text = str(GameData.capacity)
	
