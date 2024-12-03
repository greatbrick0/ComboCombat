extends Node

var previousAction: int = -1

func _ready():
	get_parent().queuedActions.append(0)
	get_parent().timeToAction.append(get_node("../MovementHolder").get_child(0).cooldownTime)
	previousAction = 0

func _on_lance_enemy_queue_empty():
	if(get_parent().global_position.distance_to(get_parent().playerRef.global_position) < 3.75):
		get_parent().queuedActions.append(1)
		get_parent().timeToAction.append(get_node("../WeaponHolder").get_child(0).cooldownTime)
		previousAction = 1
	else:
		get_parent().queuedActions.append(0)
		get_parent().timeToAction.append(get_node("../MovementHolder").get_child(0).cooldownTime)
		previousAction = 0

func _process(delta):
	get_parent().actionTarget = VecUtilities.xy(get_parent().playerRef.global_position)
