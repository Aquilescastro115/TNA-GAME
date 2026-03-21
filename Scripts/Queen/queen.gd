extends Node2D

@export var speed = 80

var selected = false
var target_position = Vector2.ZERO
var moving = false
var target_bush = null
var target_mud = null

var collecting_bush = false
var collecting_mud = false
var collect_timer = 0.0
var collect_interval = 1.0


func _ready():
	target_position = global_position


func _process(delta):

	# --- RECOLECCIÓN ---
	if collecting_bush:
		collect_timer += delta

		if collect_timer >= collect_interval:
			collect_timer = 0
			collect_bush()

		return
		
	if collecting_mud:
		collect_timer += delta

		if collect_timer >= collect_interval:
			collect_timer = 0
			collect_mud()

		return

	# --- MOVIMIENTO ---
	if moving:

		var direction = target_position - global_position
		var distance = direction.length()

		# Si ya llegó
		if distance < 5:
			moving = false

			if target_bush:
				collecting_bush = true
				collect_timer = 0
			elif target_mud:
				collecting_mud = true
				collect_timer = 0

			return

		# Normalizar dirección (CLAVE para movimiento diagonal)
		direction = direction.normalized()

		# Mover
		global_position += direction * speed * delta

		# Rotación hacia donde se mueve
		rotation = direction.angle()


func collect_bush():

	if target_bush and target_bush.collect():
		GameData.food += 1
		get_parent().update_food()
	else:
		target_bush = null
		collecting_bush = false

func collect_mud():

	if target_mud and target_mud.collect():
		GameData.mud += 1
		get_parent().update_mud()
	else:
		target_mud = null
		collecting_mud = false
