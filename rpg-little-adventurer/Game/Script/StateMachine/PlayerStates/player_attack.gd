extends State

var facingDirection: String
var attackCollisionShapre: CollisionShape2D
@onready var attack_hit_box: Area2D = $"../../AttackHitBox"
const VFX_SLASH = preload("uid://401odmsmc0rf")

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
	var grassNode = area as Grass
	if grassNode:
		grassNode.GetCut()	
	var enemyNode = area.get_parent() as EnemyCharacter
	if enemyNode:
		enemyNode.GetHit(character.attackDamage, character.global_position)
		if enemyNode.isDead == false:
			SpwnSlashVFX(enemyNode.global_position)
		

func SpwnSlashVFX(pos: Vector2):
	var newVFX = VFX_SLASH.instantiate() as Node2D
	newVFX.global_position = pos + Vector2(0, -25)
	get_tree().root.add_child(newVFX)
