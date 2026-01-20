extends State

func Enter():
	super.Enter()
	character.UpdateAnimation()
	# 动画偏移修正。但是我感觉好像本来也没偏移
	character.animated_sprite_2d.offset.y -= 10

func Update():
	super.Update()

	
	if character.animated_sprite_2d.frame_progress == 1:
		character.queue_free()
