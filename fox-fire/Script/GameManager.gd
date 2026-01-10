extends Node2D

@export var slime_scene: PackedScene
@export var spawn_timer: Timer
@export var score: int = 0
@export var score_label: Label
@export var game_over_label: Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_timer.wait_time = 3.0
	spawn_timer.start()


func _process(delta: float) -> void:

	score_label.text = "Score: " + str(score)
	
	#spawn_timer.wait_time -= 0.2*delta
	#spawn_timer.wait_time = clamp(spawn_timer.wait_time, 1, 3)

func _on_spawn_slime() -> void:
	var slime_node = slime_scene.instantiate()
	slime_node.position = Vector2(260, randf_range(50, 115))
	get_tree().current_scene.add_child(slime_node)
		# 每次生成后，再调整下一次间隔
	spawn_timer.wait_time = randf_range(1.0, 3.0)

func show_game_over():
	game_over_label.visible = true
