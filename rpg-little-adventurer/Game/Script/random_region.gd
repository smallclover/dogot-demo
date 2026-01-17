extends Sprite2D

@export var randomRegion: Array[Rect2]

func _ready() -> void:
	UpdateRandomRegion()

func UpdateRandomRegion(): 
	if randomRegion:
		var randomIndex = randi_range(0, randomRegion.size() - 1)
		region_rect = randomRegion[randomIndex]
