extends Node3D

var moveSpeed: float = 5.0
var movePos: Vector2
var moveDir: Vector2

@export var maxHealth: int = 2
@export var currentHealth: int = 2

func _on_health_bar_tracker_created_element(element: Node):
	element.barWidth = 120
	element.SetColour(Color.CRIMSON)
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
