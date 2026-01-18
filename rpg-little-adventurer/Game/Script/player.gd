extends BaseCharacter


const SPEED = 150
const ACCELERATE = 5

func _unhandled_input(_event: InputEvent) -> void:
	InputDirection = Input.get_vector("Left","Right","Up", "Down")


	##lerp 使得加速缓慢进行，不至于太突然
	#velocity =velocity.lerp(InputDirection * SPEED, ACCELERATE * delta)
	#move_and_slide()
