extends Node3D

@export var maxDistance: float = 2.5
@export var travelSpeed: float = 2.0
@export var cooldownTime: float = 1.0
var timeSinceUse: float = 0.0
var ownerBody: Node3D

func _ready():
	ownerBody = get_parent().get_parent()

func EvaluateSpecial() -> bool:
	return ownerBody.MatchPattern([1]) or ownerBody.MatchPattern([2])

func _process(delta):
	timeSinceUse += 1.0 * delta

func AttemptAction(pos: Vector2, recordData: int) -> void:
	if(timeSinceUse < cooldownTime): return
	if(EvaluateSpecial()):
		ownerBody.MoveCommand(pos, travelSpeed * 5.0, maxDistance * 1.5)
	else:
		ownerBody.MoveCommand(pos, travelSpeed, maxDistance)
	ownerBody.RecordAction(recordData)
	timeSinceUse = 0.0
