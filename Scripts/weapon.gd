extends Node

@export var comboPattern: Array = [0, 0, 0]
@export var cooldownTime: float = 1.0
var timeSinceUse: float = 0.0
var ownerBody: Node

func _ready():
	ownerBody = get_parent().get_parent()

func EvaluateSpecial() -> bool:
	return ownerBody.MatchPattern(comboPattern)

func _process(delta):
	timeSinceUse += 1.0 * delta

func AttemptAction(pos: Vector2, recordData: int) -> void:
	if(timeSinceUse < cooldownTime): return
	if(EvaluateSpecial()):
		ownerBody.MoveCommand(pos, 2, 2)
	else:
		ownerBody.MoveCommand(pos, 2, 2)
	ownerBody.RecordAction(recordData)
	timeSinceUse = 0.0
