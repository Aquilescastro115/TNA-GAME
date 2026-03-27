extends Node2D

@onready var tienda = $"../Canvas/Tienda"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Esta funcion se dispara al apretar el nido
func _on_touch_screen_button_released() -> void:
	tienda.show()

#todo Interfaz grafica de nido
