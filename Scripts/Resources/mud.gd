extends Node2D

@export var mud_amount = 5

func _ready():
	add_to_group("mud")

func collect():
	if mud_amount > 0:
		mud_amount -= 1

		if mud_amount <= 0:
			queue_free()

		return true

	return false
