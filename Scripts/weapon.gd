extends Node

@export var comboPattern: Array[int] = [0, 0, 0]
@export var cooldownTime: float = 1.0
var timeSinceUse: float = 0.0
var ownerBody: Node3D

func _ready():
	ownerBody = get_parent().get_parent()

func EvaluateSpecial() -> bool:
	return ownerBody.MatchPattern(comboPattern)

func _process(delta):
	timeSinceUse += 1.0 * delta

func AttemptAction(pos: Vector2, recordData: int) -> void:
	if(timeSinceUse < cooldownTime): return
	ownerBody.look_at(VecUtilities.xyz(pos))
	if(EvaluateSpecial()):
		$Special.play("activate")
	else:
		$Basic.play("activate")
	ownerBody.RecordAction(recordData)
	timeSinceUse = 0.0

func MoveRelative(direction: Vector2, speed: float, dist: float) -> void:
	var moveGoal: Vector3 = ownerBody.transform.basis.z * direction.x + ownerBody.transform.basis.y * direction.y
	moveGoal += ownerBody.position
	ownerBody.MoveCommand(VecUtilities.xy(moveGoal), speed, dist)

func RefundCooldown(refund: float) -> void:
	timeSinceUse += refund
