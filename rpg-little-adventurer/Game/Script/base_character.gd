extends CharacterBody2D
class_name BaseCharacter


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
