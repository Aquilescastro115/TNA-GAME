extends Node2D

@onready var queen = $Queen
@onready var food_label = $UI/HBoxContainer/FoodVar
@onready var cap_label = $UI/HBoxContainer/CapVar
@onready var mud_label = $UI/HBoxContainer/MudVar
@export var ant_scene: PackedScene
@onready var nest = $Nest

func _ready():
	update_food()
	update_cap()
	update_mud()

func _input(event):

	if not queen.selected:
		return

	if event is InputEventScreenTouch and event.pressed:
		handle_click(event.position)

	if event is InputEventMouseButton and event.pressed:
		handle_click(event.position)


func handle_click(pos):
	for mud in get_tree().get_nodes_in_group("mud"):

		var sprite = mud.get_node("Mud") # asegúrate que el nodo se llame así
		var size = sprite.texture.get_size() * sprite.scale

		var rect = Rect2(mud.global_position, size)

		if rect.has_point(pos):

			queen.target_position = mud.global_position + size / 2
			queen.target_mud = mud
			queen.target_bush = null
			queen.moving = true
			queen.selected = false
			return

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

func update_mud():
	mud_label.text = str(GameData.mud)

func spawn_ant():
	var ant = ant_scene.instantiate()
	ant.global_position = nest.global_position
	add_child(ant)
