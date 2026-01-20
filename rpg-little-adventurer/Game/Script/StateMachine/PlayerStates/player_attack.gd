extends State

var facingDirection: String
var attackCollisionShapre: CollisionShape2D
@onready var attack_hit_box: Area2D = $"../../AttackHitBox"

func Enter():
	super.Enter()
	
	character.UpdateAnimation()
	
	facingDirection = character.facingDirection
	var collisionShape_node = attack_hit_box.get_node("CollisionShape2D_" + facingDirection)
	if collisionShape_node:
		attackCollisionShapre = collisionShape_node

func Update():
	super.Update()
	
	#在第二帧启用碰撞体 
	if parentStateMachine.animated_sprite_2d.frame == 2:
		attackCollisionShapre.disabled = false
	elif parentStateMachine.animated_sprite_2d.frame == 5:
		attackCollisionShapre.disabled = true
	
	if parentStateMachine.animated_sprite_2d.is_playing() == false:
		parentStateMachine.SwitchTo("Idle")

func Ready():
	super.Ready()
	
	for child in attack_hit_box.get_children():
		var childCollisionShape = child as CollisionShape2D
		if childCollisionShape:
			childCollisionShape.disabled = true

func Exit():
	super.Exit()
	#攻击动画停止时，停止碰撞体
	attackCollisionShapre.disabled = true


func _on_attack_hit_box_area_entered(area: Area2D) -> void:
	area.get_parent().GetHit(character.attackDamage)
