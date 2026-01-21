extends BaseCharacter
class_name EnemyCharacter

@onready var line_2d: Line2D = $Line2D
var player: BaseCharacter
var playDirection: Vector2
var playAngle: float

func _ready() -> void:
	player = get_tree().root.get_node("SceneRoot/Level/Player")

func _process(_delta: float) -> void:
	playDirection = player.global_position - global_position
	playDirection = playDirection.normalized()
	
	if showDebugVisual:
		line_2d.points[1] = playDirection * 40
	else:
		line_2d.points[1] = Vector2.ZERO
	
	playDirection.y = -playDirection.y
	playAngle = rad_to_deg(playDirection.angle())
	if playAngle < 0:
		playAngle += 360

func GetDirectionName() -> String:
	facingDirection = "Up"
	if playAngle > 135 && playAngle <= 225:
		facingDirection = "Left"
	elif playAngle > 225 && playAngle <= 315:
		facingDirection = "Down"
	elif playAngle > 315 || playAngle <= 45:
		facingDirection = "Right"
	return facingDirection
