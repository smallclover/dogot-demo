extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# x速度50，y是0
	velocity = Vector2(50, 0)

# 导出变量到检查器方便调试
@export var move_speed: float = 50
@export var animator : AnimatedSprite2D
var is_game_over: bool = false
@export var bullet_scene : PackedScene
@export var fire_sound: AudioStreamPlayer
@export var game_over_sound: AudioStreamPlayer
@export var running_sound: AudioStreamPlayer
@export var restart_timer: Timer
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	## 向上是负
	#velocity = Input.get_vector("left","right","up", "down") * move_speeda
	#move_and_slide()

func _process(delta: float) -> void:
	if velocity == Vector2.ZERO or is_game_over:
		running_sound.stop()
	elif not running_sound.playing:
		running_sound.play()
	
		

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
	if not is_game_over:
		is_game_over = true
		animator.play("game_over")
		
		get_tree().current_scene.show_game_over()
		game_over_sound.play()
		
		restart_timer.start()


func _on_fire() -> void:
	if velocity != Vector2.ZERO or is_game_over:
		return
	fire_sound.play()
	var bullet_node = bullet_scene.instantiate()
	bullet_node.position = position + Vector2(6,6)
	get_tree().current_scene.add_child(bullet_node)


func _on_reload_scene() -> void:
	get_tree().reload_current_scene()
