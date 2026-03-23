extends Node

const SAVE_PATH = "user://save_game.save"

func save_game():

	var data = {
		"food": GameData.food,
		"queen_position_x": GameData.queen_position.x,
		"queen_position_y": GameData.queen_position.y
	}

	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	file.store_var(data)
	file.close()

	print("Juego guardado")


func load_game():

	if not FileAccess.file_exists(SAVE_PATH):
		print("No hay partida guardada")
		return false

	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	var data = file.get_var()
	file.close()

	GameData.food = data["food"]
	GameData.queen_position = Vector2(
		data["queen_position_x"],
		data["queen_position_y"]
	)

	print("Juego cargado")
	return true
