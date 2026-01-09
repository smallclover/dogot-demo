extends Control

@export var pause_panel: Panel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# 监听esc菜单
func _input(event: InputEvent) -> void:
	if event is InputEventKey:
		if event.keycode == KEY_ESCAPE and event.pressed:
			if not get_tree().paused:
				pause()
			else:
				unpause()

func pause():
	get_tree().paused = true
	pause_panel.visible = true

func unpause():
	get_tree().paused = false
	pause_panel.visible = false

func quit_game():
	get_tree().quit()
