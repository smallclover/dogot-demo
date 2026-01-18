extends State

func UpdatePhysics(delta: float):
	super.UpdatePhysics(delta)
	
	if character.InputDirection.length() > 0:
		parentStateMachine.SwitchTo("Move")

func Update():
	super.Update()
	character.UpdateAnimation()
