extends Node2D

@export var food_amount = 5

func _ready():
	add_to_group("food")

func collect():
	print("intentando recolectar")
	if food_amount > 0:
		food_amount -= 1

		if food_amount <= 0:
			queue_free()

		return true

	return false
