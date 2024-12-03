extends Node3D

var recordedActions: Array = []
var maxRecordedActions: int = 5

var moveSpeed: float = 5.0
var movePos: Vector2
var moveDir: Vector2

@export var maxHealth: int = 4
@export var currentHealth: int = 4

var hudRef: Node

func Initialize(newHudRef: Node) -> void:
	maxRecordedActions = max(
		$LeftWeaponHolder.get_child(0).comboPattern.size(), 
		$RightWeaponHolder.get_child(0).comboPattern.size(), 
		1)
	for ii in maxRecordedActions:
		recordedActions.append(-1)
	hudRef = newHudRef

func _process(delta):
	moveDir = VecUtilities.xy(global_position).direction_to(movePos)
	global_position += VecUtilities.xyz(moveDir * moveSpeed * delta)
	if(VecUtilities.xy(global_position).distance_squared_to(movePos) <= 0.0001):
		global_position = VecUtilities.xyz(movePos)
	
	var mousePos: Vector2 = VecUtilities.MouseWorldPos(get_viewport().get_camera_3d())
	if(Input.is_action_just_pressed("MiddleTool")):
		$MovementHolder.get_child(0).AttemptAction(mousePos, 0)
	if(Input.is_action_just_pressed("LeftTool")):
		$LeftWeaponHolder.get_child(0).AttemptAction(mousePos, 1)
	if(Input.is_action_just_pressed("RightTool")):
		$RightWeaponHolder.get_child(0).AttemptAction(mousePos, 2)
	
	for ii in ["Movement", "LeftWeapon", "RightWeapon"]:
		var equipment: Node = get_node(ii+"Holder").get_child(0)
		hudRef.get_node(ii+"/Sprite2D/ProgressBar").value = 1 - equipment.timeSinceUse / equipment.cooldownTime
		if(equipment.EvaluateSpecial()): hudRef.get_node(ii+"/Sprite2D").self_modulate = Color.AQUA
		else: hudRef.get_node(ii+"/Sprite2D").self_modulate = Color.WHITE
	
	if(currentHealth == 1): $DangerSound.play()
	else: $DangerSound.stop()

func MoveCommand(newTargetPos: Vector2, newMoveSpeed: float, maxDist: float) -> void:
	movePos = VecUtilities.xy(global_position) + (newTargetPos - VecUtilities.xy(global_position)).limit_length(maxDist)
	movePos = VecUtilities.RoundToGrid(movePos)
	moveSpeed = newMoveSpeed

func RecordAction(action: int) -> void:
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
	element.SetUpSegments(maxHealth)
	element.UpdateValue(currentHealth)
	element.queue_redraw()

func _on_hitbox_area_entered(area):
	currentHealth -= 1
	if(currentHealth <= 0):
		print("dead")
	else:
		$HealthBarTracker.instance.UpdateValue(currentHealth)
		$HurtSound.play()
