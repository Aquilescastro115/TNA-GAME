extends Node2D

@export var speed = 80

var selected = false
var target_position = Vector2.ZERO
var moving = false

func _ready():
	target_position = global_position

func _process(delta):

	if moving:
		var direction = target_position - global_position

		if direction.length() > 5:
			global_position += direction.normalized() * speed * delta
			rotation = direction.angle()
		else:
			moving = false
