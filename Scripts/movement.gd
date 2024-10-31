extends Node3D

@export var maxDistance: float = 2.5
@export var travelSpeed: float = 2.0
@export var cooldownTime: float = 1.0
var timeSinceUse: float = 0.0

func _process(delta):
	if(timeSinceUse >= cooldownTime):
		if(Input.is_action_just_pressed("MiddleTool")):
			if(get_parent().MatchPattern([1]) or get_parent().MatchPattern([2])):
				get_parent().MoveCommand(VecUtilities.MouseWorldPos(get_viewport().get_camera_3d()), travelSpeed * 5.0, maxDistance * 1.5)
			else:
				get_parent().MoveCommand(VecUtilities.MouseWorldPos(get_viewport().get_camera_3d()), travelSpeed, maxDistance)
			get_parent().RecordAction(0)
			timeSinceUse = 0.0
	else:
		timeSinceUse += 1.0 * delta
