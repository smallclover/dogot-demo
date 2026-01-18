extends Node
class_name StateMachine

var currentState: State

@onready var debug_label: Label = $"../DebugLabel"

func _ready() -> void:
	for child in get_children():
		var childState = child as State
		childState.parentStateMachine = self
		childState.character = get_parent()
		childState.Ready()
	
	currentState = get_child(0)
	currentState.Enter()

func _physics_process(delta: float) -> void:
	currentState.UpdatePhysics(delta)

# 不使用的参数可以在参数名前面加上下划线
func _process(_delta: float) -> void:
	currentState.Update()
	if Input.is_physical_key_pressed(KEY_SPACE):
		SwitchTo("Move")

func SwitchTo(targetState: String):
	var nextStateNode = get_node(targetState)
	if !nextStateNode:
		# 没有发现状态直接返回
		return
	currentState.Exit()
	currentState = nextStateNode
	currentState.Enter()
