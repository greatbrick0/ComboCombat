extends Node3D
class_name Enemy

var moveSpeed: float = 0.0
var movePos: Vector2
var moveDir: Vector2

@export var maxHealth: int = 2
@export var currentHealth: int = 2
var alive: bool = true
signal died

var playerRef: Node3D
var actionTarget: Vector2
var queuedActions: Array[int] = []
var timeToAction: Array[float] = []
signal queueEmpty

func _ready():
	movePos = VecUtilities.xy(global_position)

func _process(delta):
	moveDir = VecUtilities.xy(global_position).direction_to(movePos)
	global_position += VecUtilities.xyz(moveDir * moveSpeed * delta)
	if(VecUtilities.xy(global_position).distance_squared_to(movePos) <= 0.0001):
		global_position = VecUtilities.xyz(movePos)
	
	if(!queuedActions.is_empty()):
		if(timeToAction[0] > 0.0):
			timeToAction[0] -= 1.0 * delta
		else:
			if(queuedActions[0] == 0): $MovementHolder.get_child(0).AttemptAction(actionTarget, 0)
			else: $WeaponHolder.get_child(queuedActions[0] - 1).AttemptAction(actionTarget, 0)
			queuedActions.pop_front()
			timeToAction.pop_front()
			if(queuedActions.is_empty()): emit_signal("queueEmpty")

func MoveCommand(newTargetPos: Vector2, newMoveSpeed: float, maxDist: float) -> void:
	movePos = VecUtilities.xy(global_position) + (newTargetPos - VecUtilities.xy(global_position)).limit_length(maxDist)
	movePos = VecUtilities.RoundToGrid(movePos)
	moveSpeed = newMoveSpeed

func RecordAction(action: int) -> void:
	pass

func MatchPattern(pattern: Array, matchArray: Array = []) -> bool:
	return false

func _on_health_bar_tracker_created_element(element: Node):
	element.barWidth = 120
	element.SetColour(Color.CRIMSON)
	element.SetUpSegments(maxHealth)
	element.UpdateValue(currentHealth)
	element.queue_redraw()

func _on_hitbox_area_entered(area):
	if(!alive): return
	
	currentHealth -= 1
	if(currentHealth <= 0):
		alive = false
		$DeathSound.play()
		$DeathParticles.emitting = true
		$Mesh.visible = false
		$HealthBarTracker.queue_free()
		emit_signal("died")
		await get_tree().create_timer(3.0).timeout
		queue_free()
	else:
		$HealthBarTracker.instance.UpdateValue(currentHealth)
		$HurtSound.play()
