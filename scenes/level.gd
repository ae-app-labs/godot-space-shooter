extends Node2D

var meteor_scene: PackedScene = load("res://scenes/Meteor.tscn")
var laser_scene: PackedScene = load("res://scenes/laser.tscn")

var health:int = 3

func _on_meteor_timer_timeout() -> void:
	var meteor = meteor_scene.instantiate()
	$Meteors.add_child(meteor)
	
	meteor.connect('collission', _on_meteor_collission)

func _on_meteor_collission():
	health -= 1
	get_tree().call_group('ui', 'set_health', health)
	$Player.play_collission_sound()
	
	if health <= 0:
		get_tree().change_scene_to_file("res://scenes/game_over.tscn")

func _on_player_laser(pos) -> void:
	var laser = laser_scene.instantiate()
	$Lasers.add_child(laser)
	laser.position = pos

func _ready():
	var size= get_viewport().get_visible_rect().size
	var rng = RandomNumberGenerator.new()
	get_tree().call_group('ui', 'set_health', health)
	
	for star in $Stars.get_children():
		var random_x = rng.randi_range(0, int(size.x))
		var random_y = rng.randi_range(0, int(size.y))
		star.position = Vector2(random_x, random_y)
		
		var rand_scale = rng.randi_range(1, 2)
		star.scale = Vector2(rand_scale, rand_scale)
		
		star.speed_scale = rng.randf_range(0.6, 1.4)
	
