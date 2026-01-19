# 可以使编辑器调用这个脚本
@tool 
extends Sprite2D

@export var randomRegion: Array[Rect2]
# 随机种子控制树木的颜色，保证每次的随机都是一样的
var seedNumber: int

func _ready() -> void:
	UpdateRandomRegion()

func UpdateRandomRegion(): 
	if randomRegion:
		seedNumber = int(global_position.x + global_position.y)
		seed(seedNumber)
		var randomIndex = randi_range(0, randomRegion.size() - 1)
		region_rect = randomRegion[randomIndex]

func _enter_tree() -> void:
	# 这个函数只在编辑器里调用
	set_notify_transform(true)

func _notification(what: int) -> void:
	if what == NOTIFICATION_TRANSFORM_CHANGED:
		if Engine.is_editor_hint():
			UpdateRandomRegion()
