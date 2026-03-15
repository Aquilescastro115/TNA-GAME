extends Node2D

@export var speed = 80

var selected = false
var target_position = Vector2.ZERO
var moving = false

func _ready():
	target_position = global_position


func _process(delta):

	if moving:

		var diff = target_position - global_position
		var move = Vector2.ZERO

		# mover primero en X
		if abs(diff.x) > 5:
			move.x = sign(diff.x)

		# cuando X ya está alineado mover en Y
		elif abs(diff.y) > 5:
			move.y = sign(diff.y)

		else:
			moving = false
			return

		global_position += move * speed * delta

		if move.length() > 0:
			rotation = move.angle()
