extends State

const SPEED = 150
const ACCELERATE = 5

func UpdatePhysics(delta: float):
	super.UpdatePhysics(delta)
	
	character.velocity = character.velocity.lerp(character.InputDirection * SPEED, ACCELERATE * delta)
	character.move_and_slide()

func Update():
	super.Update()
	character.UpdateAnimation()
	
	if character.InputDirection == Vector2.ZERO:
		parentStateMachine.SwitchTo("Idle")
		return
	
	if Input.is_action_just_pressed("Attack"):
		parentStateMachine.SwitchTo("Attack")
