extends Node

var previousAction: int = -1

func _ready():
	get_parent().queuedActions.append(0)
	get_parent().timeToAction.append(get_node("../MovementHolder").get_child(0).cooldownTime)
	previousAction = 0

func _on_small_enemy_queue_empty():
	if(previousAction == 0):
		get_parent().queuedActions.append(1)
		get_parent().timeToAction.append(get_node("../WeaponHolder").get_child(0).cooldownTime)
		previousAction = 1
	else:
		get_parent().queuedActions.append(0)
		get_parent().timeToAction.append(get_node("../MovementHolder").get_child(0).cooldownTime)
		previousAction = 0

func _process(delta):
	var angle: float = randf_range(0, TAU)
	var extra: Vector2 = Vector2.ZERO
	if(previousAction == 0): extra = Vector2(cos(angle), sin(angle)) * 1.5
	get_parent().actionTarget = VecUtilities.xy(get_parent().playerRef.global_position) + extra
