extends CharacterBody2D

var InputDirection: Vector2 = Vector2.ZERO
const SPEED = 150
const ACCELERATE = 5
var facingDirection: String = "Down"

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var animationToPlay: String

func _physics_process(delta: float) -> void:
	InputDirection = Input.get_vector("Left","Right","Up", "Down")
	
	#lerp 使得加速缓慢进行，不至于太突然
	velocity =velocity.lerp(InputDirection * SPEED, ACCELERATE * delta)
	move_and_slide()
	
	if velocity.length() > 20:
		animationToPlay = "Run_" + GetDirectionName()
	else:
		animationToPlay = "Idle_" + GetDirectionName()
		
	animated_sprite_2d.play(animationToPlay)
	
func GetDirectionName() -> String:
	if InputDirection == Vector2.ZERO:
		return facingDirection
	
	if InputDirection.y > 0:
		facingDirection = "Down"
	elif InputDirection.y < 0:
		facingDirection = "Up"
	else:
		if InputDirection.x > 0:
			facingDirection = "Right"
		elif InputDirection.x < 0:
			facingDirection = "Left"
		
	return facingDirection
