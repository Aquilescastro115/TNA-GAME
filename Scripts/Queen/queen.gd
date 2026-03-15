extends Node2D

@export var speed = 80

var selected = false
var target_position = Vector2.ZERO
var moving = false
var target_bush = null

var collecting = false
var collect_timer = 0.0
var collect_interval = 1.0


func _ready():
	target_position = global_position


func _process(delta):

	if collecting:

		collect_timer += delta

		if collect_timer >= collect_interval:
			collect_timer = 0
			collect_bush()

		return


	if moving:

		var diff = target_position - global_position
		var move = Vector2.ZERO

		if abs(diff.x) > 5:
			move.x = sign(diff.x)

		elif abs(diff.y) > 5:
			move.y = sign(diff.y)

		else:
			moving = false

			if target_bush:
				collecting = true

			return

		global_position += move * speed * delta

		if move.length() > 0:
			rotation = move.angle()


func collect_bush():

	if target_bush and target_bush.collect():
		GameData.food += 1
		get_parent().update_food()
	else:
		target_bush = null
		collecting = false
