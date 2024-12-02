extends Node3D
class_name Enemy

var moveSpeed: float = 5.0
var movePos: Vector2
var moveDir: Vector2

@export var maxHealth: int = 2
@export var currentHealth: int = 2
var alive: bool = true
signal died

func RecordAction(action: int) -> void:
	pass

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
