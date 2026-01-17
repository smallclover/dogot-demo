extends Area2D

# collision layer 表明该节点属于哪一层
# collision mask 表明该节点与哪一层发生碰撞

# 补间动画
# skew 倾斜度
var skewTween: Tween
var skewTweenBack: Tween
var scaleTween: Tween
var startScale = Vector2(1.0, 1.0)
var endScale = Vector2(1.0, 0.5)

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var sprite_2d_back: Sprite2D = $Sprite2D_Back

func _ready() -> void:
	var startSkew = deg_to_rad(randf_range(-10, 10))
	var endSkew = -startSkew
	
	# 前草
	skewTween = get_tree().create_tween().set_loops()
	skewTween.tween_property(sprite_2d, "skew", endSkew, 1.5).from(startSkew)
	skewTween.tween_property(sprite_2d, "skew", startSkew, 1.5).from(endSkew)
	skewTween.set_ease(Tween.EASE_IN_OUT)
	skewTween.set_speed_scale(randf_range(0.5, 1.5))
	
	# 后草
	var startSkewBack = endSkew * 0.5
	var endSkewBack = -startSkewBack
	skewTweenBack = get_tree().create_tween().set_loops()
	skewTweenBack.tween_property(sprite_2d_back, "skew", endSkewBack, 1.5).from(startSkewBack)
	skewTweenBack.tween_property(sprite_2d_back, "skew", startSkewBack, 1.5).from(endSkewBack)
	skewTweenBack.set_ease(Tween.EASE_IN_OUT)


func _on_body_entered(body: Node2D) -> void:
	CreateNewScaleTween(endScale,0.1)


func _on_body_exited(body: Node2D) -> void:
	CreateNewScaleTween(startScale,0.5)

func CreateNewScaleTween(targetValue:Vector2, duration:float):
	if scaleTween:
		scaleTween.kill()
	scaleTween = get_tree().create_tween()
	scaleTween.tween_property(sprite_2d, "scale", targetValue, duration)
	scaleTween.set_ease(Tween.EASE_OUT)
