extends Control

var level_scene:PackedScene = load("res://scenes/Level.tscn")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("shoot"):
		get_tree().change_scene_to_packed(level_scene)
