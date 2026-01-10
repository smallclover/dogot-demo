extends Node2D

@export var level1: PackedScene

func _on_play_pressed() -> void:
	get_tree().change_scene_to_packed(level1)
	# 这两种应该都可以
	#get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
	


func _on_quit_pressed() -> void:
	get_tree().quit()
