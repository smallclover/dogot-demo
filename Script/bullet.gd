extends Area2D


@export var bullet_speed : float = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# 在3秒之后销毁子弹，否则子弹的节点会不断的增加
	await get_tree().create_timer(3).timeout
	queue_free()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	position += Vector2(bullet_speed, 0) * delta
