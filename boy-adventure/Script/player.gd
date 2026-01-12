extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anime_player: AnimatedSprite2D = $AnimatedSprite2D

var facing : int = 1


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	# ui_accept：通常对应的是 空格键 (Space)、回车键 (Enter) 或手柄上的 A 键。
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		if velocity.y < 0:
			anime_player.play("jump")
		else:
			anime_player.play("fall")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		facing = sign(direction)
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anime_player.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anime_player.play("idle")
		
	anime_player.flip_h = (facing == -1)
	
	move_and_slide()
