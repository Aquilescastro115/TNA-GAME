extends CanvasLayer

# --- CONFIGURACIÓN DE RUTAS ---
const GAME_SCENE_PATH : String = "res://Scenes/world.tscn"
const OPTIONS_SCENE_PATH : String = "res://Scenes/Options.tscn"

# --- REFERENCIAS A LOS NODOS ---
@onready var play_button: Button = $MenuInterface/MainLayout/ButtonsContainer/PlayButton
@onready var options_button: Button = $MenuInterface/MainLayout/ButtonsContainer/OptionsButton
@onready var exit_button: Button = $MenuInterface/MainLayout/ButtonsContainer/ExitButton

func _ready() -> void:
	play_button.grab_focus()
	
	play_button.pressed.connect(_on_play_button_pressed)
	options_button.pressed.connect(_on_options_button_pressed)
	exit_button.pressed.connect(_on_exit_button_pressed)
	
	play_button.mouse_entered.connect(_on_button_hover)
	options_button.mouse_entered.connect(_on_button_hover)
	exit_button.mouse_entered.connect(_on_button_hover)

# --- FUNCIONES DE RESPUESTA ---

func _on_play_button_pressed() -> void:
	print("Cargando el hormiguero... Iniciando juego.")
	if ResourceLoader.exists(GAME_SCENE_PATH):
		get_tree().change_scene_to_file(GAME_SCENE_PATH)
	else:
		push_warning("Error: No se encontró la escena del juego en: " + GAME_SCENE_PATH)

func _on_options_button_pressed() -> void:
	print("Abriendo menú de opciones.")
	if ResourceLoader.exists(OPTIONS_SCENE_PATH):
		get_tree().change_scene_to_file(OPTIONS_SCENE_PATH)
	else:
		print("Escena de opciones no implementada aún.")

func _on_exit_button_pressed() -> void:
	print("Cerrando el juego. ¡Adiós!")
	get_tree().quit()

func _on_button_hover() -> void:
	pass
