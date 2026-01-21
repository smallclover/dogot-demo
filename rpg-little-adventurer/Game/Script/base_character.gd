extends CharacterBody2D
class_name BaseCharacter


@export var maxHealth = 100
@onready var currentHealth = maxHealth:
	set(value):
		currentHealth = clampi(value, 0, maxHealth)
		if currentHealth == 0:
			isDead = true
			
var isDead = false
@export var attackDamage = 50

var knockBackDirection: Vector2 = Vector2.ZERO
var InputDirection: Vector2 = Vector2.ZERO
var facingDirection: String = "Down"
var animationToPlay: String
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachine = $StateMachine

@export var showDebugVisual = true

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

func UpdateAnimation():
	animated_sprite_2d.play(state_machine.currentState.name + "_" + GetDirectionName())
	
func GetHit(damage: int, fromPoint = Vector2.ZERO):
	if isDead:
		return
	
	StartBlink()
	currentHealth -= damage
	
	knockBackDirection = (global_position - fromPoint).normalized()
	
	if isDead:
		state_machine.SwitchTo("Die")
	else:
		state_machine.SwitchTo("Hurt")
		
func UpdateBlink(newValue: float):
	animated_sprite_2d.set_instance_shader_parameter("Blink", newValue)
	
func StartBlink():
	var blink_tween = get_tree().create_tween()
	blink_tween.tween_method(UpdateBlink, 1.0, 0.0, 0.3)
