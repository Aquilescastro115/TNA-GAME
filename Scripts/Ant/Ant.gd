extends Node2D

enum State { SEARCH, RETURN_HOME }

@export var speed = 40

var state = State.SEARCH
var direction = Vector2.ZERO
var nest_position = Vector2(80, 128)

func _ready():
	randomize()
	change_direction()

func _process(delta):

	match state:
		State.SEARCH:
			search_food()
		State.RETURN_HOME:
			go_home()

	position += direction * speed * delta

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
	var angle = randf() * TAU
	direction = Vector2(cos(angle), sin(angle))
