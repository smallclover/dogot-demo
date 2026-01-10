extends Camera2D

@export var speed: float = 100

func _process(delta):
	position.x += speed * delta
