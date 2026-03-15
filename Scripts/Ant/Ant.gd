extends Node2D

enum State { SEARCH, RETURN_HOME }

@export var speed = 40

var state = State.SEARCH
var direction = Vector2.ZERO
var nest_position = Vector2(80, 128)

var screen_size
var margin = 8

func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	change_direction()

func _process(delta):

	match state:
		State.SEARCH:
			search_food()

		State.RETURN_HOME:
			go_home()

	position += direction * speed * delta

	position.x = clamp(position.x, margin, screen_size.x - margin)
	position.y = clamp(position.y, margin, screen_size.y - margin)

	if direction.length() > 0:
		rotation = direction.angle()

func search_food():
	if randi() % 100 < 2:
		change_direction()

func go_home():

	direction = (nest_position - global_position).normalized()

	if global_position.distance_to(nest_position) < 10:
		state = State.SEARCH
		
func change_direction():

	var directions = [Vector2.RIGHT,Vector2.LEFT,Vector2.UP,Vector2.DOWN]
	direction = directions.pick_random()

func detect_food():

	var foods = get_tree().get_nodes_in_group("food")

	for food in foods:

		if global_position.distance_to(food.global_position) < 30:

			state = State.RETURN_HOME
			nest_position = food.global_position

			var system = get_node("/root/World/FoodDetectionSystem")
			system.notify_food_found(food.global_position)
