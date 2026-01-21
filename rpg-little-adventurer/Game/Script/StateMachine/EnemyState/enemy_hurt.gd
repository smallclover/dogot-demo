extends State

func Enter():
	super.Enter()
	character.UpdateAnimation()

func Update():
	super.Update()
	
	if character.animated_sprite_2d.frame_progress == 1:
		parentStateMachine.SwitchTo("Idle")

func UpdatePhysics(delta: float):
	super.UpdatePhysics(delta)
	if character.animated_sprite_2d.frame == 0:
		character.move_and_collide(character.knockBackDirection * delta * 50)
