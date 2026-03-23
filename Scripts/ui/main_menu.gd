extends Control

func _ready():

	$VBoxContainer/NewGame.pressed.connect(_on_new_game)
	$VBoxContainer/LoadGame.pressed.connect(_on_load_game)
	$VBoxContainer/Instagram.pressed.connect(_on_instagramdc)
	$VBoxContainer/Instagram.pressed.connect(_on_instagrampc)
	$VBoxContainer/Exit.pressed.connect(_on_exit)


func _on_new_game():
	GameData.reset()
	get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_load_game():
	if SaveSystem.load_game():
		get_tree().change_scene_to_file("res://scenes/world.tscn")


func _on_instagramdc():
	OS.shell_open("https://www.instagram.com/aquilescastro_xd/")


func _on_instagrampc():
	OS.shell_open("https://www.instagram.com/takkunn._/")


func _on_exit():
	get_tree().quit()
