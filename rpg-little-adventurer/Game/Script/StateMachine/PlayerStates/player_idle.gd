extends State

func UpdatePhysics(delta: float):
	super.UpdatePhysics(delta)


func Update():
	super.Update()
	character.UpdateAnimation()
	
	if character.InputDirection.length() > 0:
		parentStateMachine.SwitchTo("Move")
		return
	
	if Input.is_action_just_pressed("Attack"):
		parentStateMachine.SwitchTo("Attack")
