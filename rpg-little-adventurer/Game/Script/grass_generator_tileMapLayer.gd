extends TileMapLayer
# 草的场景文件，这里是场景文件的uid，即使移动了文件也不会有问题
const GRASS = preload("uid://d0f2424w2cyw")

func _ready() -> void:
	visible = false
	
	var cellArray = get_used_cells()
	
	for cellCorrdinate in cellArray:
		var newGrass = GRASS.instantiate()
		newGrass.global_position = global_position + cellCorrdinate * 32.0 + Vector2(16, 16)
		get_parent().add_child.call_deferred(newGrass)
		
