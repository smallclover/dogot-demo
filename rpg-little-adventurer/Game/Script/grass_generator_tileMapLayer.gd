extends TileMapLayer
# 草的场景文件，这里是场景文件的uid，即使移动了文件也不会有问题
const GRASS = preload("uid://d0f2424w2cyw")

const OFFSET = 10

func _ready() -> void:
	enabled = false
	
	var cellArray = get_used_cells()
	
	for cellCorrdinate in cellArray:
		var newGrass = GRASS.instantiate()
		newGrass.global_position = global_position + cellCorrdinate * 32.0 + Vector2(16, 16)
		get_parent().add_child.call_deferred(newGrass)
		
		# 让草在一定范围内随机生成
		var randomOffset = Vector2(randf_range(-OFFSET, OFFSET), randf_range(-OFFSET, OFFSET))
		newGrass.global_position += randomOffset
		
		# 让草的icon随机反转
		newGrass.get_node("Sprite2D").flip_h = randi_range(0, 1)
		(newGrass.get_node("Sprite2D_Back") as Sprite2D).flip_h = randi_range(0, 1)
