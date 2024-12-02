extends Node3D

@export var maxDistance: float = 2.5
@export var travelSpeed: float = 2.0
@export var cooldownTime: float = 1.0
var timeSinceUse: float = 0.0

func EvaluateSpecial() -> bool:
	return get_parent().get_parent().MatchPattern([1]) or get_parent().get_parent().MatchPattern([2])

func _process(delta):
	if(Input.is_action_just_pressed("MiddleTool")):
		AttemptAction(VecUtilities.MouseWorldPos(get_viewport().get_camera_3d()))
	timeSinceUse += 1.0 * delta

func AttemptAction(pos: Vector2) -> void:
	if(timeSinceUse < cooldownTime): return
	if(EvaluateSpecial()):
		get_parent().get_parent().MoveCommand(pos, travelSpeed * 5.0, maxDistance * 1.5)
	else:
		get_parent().get_parent().MoveCommand(pos, travelSpeed, maxDistance)
	get_parent().get_parent().RecordAction(0)
	timeSinceUse = 0.0
