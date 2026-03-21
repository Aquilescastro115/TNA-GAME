extends Node2D

@onready var tilemap = $Terrain

const SOURCE_ID = 0

@onready var queen = $Queen

var grass_tiles = [
	Vector2i(0,0),
	Vector2i(1,0),
	Vector2i(2,0),
	Vector2i(3,0),
	Vector2i(4,0),
	Vector2i(5,0),
	Vector2i(0,1),
	Vector2i(1,1),
	Vector2i(2,1),
	Vector2i(3,1),
]
var noise = FastNoiseLite.new()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	noise.frequency = 0.08
	generate_world()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func generate_world():
	for x in 50:
		for y in 50:
			
			var coords = get_grass_tile(x, y)
			tilemap.set_cell(Vector2i(x,y), SOURCE_ID, coords)
func get_grass_tile(x, y):
	var n = noise.get_noise_2d(x, y)
	if n < -0.5:
		return grass_tiles[0]
	elif n < -0.2:
		return grass_tiles[1]
	elif n < 0:
		return grass_tiles[2]
	elif n < 0.2:
		return grass_tiles[3]
	elif n < 0.4:
		return grass_tiles[4]
	elif n < 0.6:
		return grass_tiles[5]
	elif n < 0.8:
		return grass_tiles[6]
	else:
		return grass_tiles[randi() % grass_tiles.size()] # rare til

	var index = int(((n + 1.0) / 2.0) * grass_tiles.size())
	index = clamp(index, 0, grass_tiles.size() - 1)

	return grass_tiles[index]

func _input(event):

	if not queen.selected:
		return

	if event is InputEventScreenTouch and event.pressed:
		handle_click(get_global_mouse_position())

	if event is InputEventMouseButton and event.pressed:
		handle_click(get_global_mouse_position())


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
