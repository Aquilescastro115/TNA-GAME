extends Node2D

@onready var queen = $Queen

func _ready():

	if GameData.queen_position != Vector2.ZERO:
		queen.global_position = GameData.queen_position

func _process(delta):

	GameData.queen_position = queen.global_position
