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
	moveDir = VecUtilities.xy(global_position).direction_to(movePos)
	global_position += VecUtilities.xyz(moveDir * moveSpeed * delta)
	if(VecUtilities.xy(global_position).distance_squared_to(movePos) <= 0.0001):
		global_position = VecUtilities.xyz(movePos)

func MoveCommand(newTargetPos: Vector2, newMoveSpeed: float, maxDist: float) -> void:
	movePos = VecUtilities.xy(global_position) + (newTargetPos - VecUtilities.xy(global_position)).limit_length(maxDist)
	movePos = VecUtilities.RoundToGrid(movePos)
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

func _on_health_bar_tracker_created_element(element: Node):
	element.SetUpSegments(4)
	element.UpdateValue(4)
	element.queue_redraw()
