extends Node3D

var recordedActions: Array = []
var maxRecordedActions: int = 5

var moveSpeed: float = 5.0
var movePos: Vector2
var moveDir: Vector2

func _ready():
	#maxRecordedActions = max($LeftWeapon.comboPattern.size(), $RightWeapon.comboPattern.size(), 1)
	for ii in maxRecordedActions:
		recordedActions.append(-1)

func _process(delta):
	moveDir = xy(global_position).direction_to(movePos)
	global_position += xyz(moveDir * moveSpeed * delta)

func MoveCommand(newTargetPos: Vector2, newMoveSpeed: float, maxDist: float) -> void:
	newTargetPos = VecUtilities.RoundToGrid(newTargetPos)
	movePos = xy(global_position) + (newTargetPos - xy(global_position)).limit_length(maxDist)
	moveSpeed = newMoveSpeed

func RecordAction(action) -> void:
	recordedActions.push_back(action)
	if(recordedActions.size() > maxRecordedActions):
		recordedActions.pop_front()

func FindMatchAmount(pattern: Array) -> int:
	var combo: Array = pattern.duplicate()
	var record: Array = recordedActions.duplicate()
	for ii in range(pattern.size()):
		if(MatchPattern(combo, record)):
			return pattern.size() - ii
		else:
			combo.pop_back()
			record.pop_front()
	return 0

func MatchPattern(pattern: Array, matchArray: Array = []) -> bool:
	if(matchArray == []):
		matchArray = recordedActions
	for ii in range(pattern.size()):
		if(matchArray[matchArray.size() - pattern.size() + ii] != pattern[ii]):
			return false
	return true

func xy(vec3: Vector3) -> Vector2:
	return Vector2(vec3.x, vec3.z)

func xyz(vec2: Vector2) -> Vector3:
	return Vector3(vec2.x, 0, vec2.y)
