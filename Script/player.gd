extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# x速度50，y是0
	velocity = Vector2(50, 0)

# 导出变量到检查器方便调试
@export var move_speed: float = 50
@export var animator : AnimatedSprite2D
var is_game_over: bool = false
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	## 向上是负
	#velocity = Input.get_vector("left","right","up", "down") * move_speed
	#move_and_slide()
	
func _physics_process(delta: float) -> void:
	if not is_game_over:
		velocity = Input.get_vector("left","right","up", "down") * move_speed
		# 速度为零播放待机动画
		if velocity == Vector2.ZERO:
			animator.play("idle")
		else:
			# 跑步动画
			animator.play("run")
		# 移动
		move_and_slide()

func game_over():
	is_game_over = true
	animator.play("game_over")
	await get_tree().create_timer(3).timeout
	get_tree().reload_current_scene()
