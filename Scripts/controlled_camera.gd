extends Camera3D

@export var offsetFromPlayer: Vector3

func _ready():
	offsetFromPlayer = global_position - %Player.global_position

func _process(delta):
	#global_position = lerp(global_position, %Player.global_position + offsetFromPlayer, 0.95 * delta)
	global_position = %Player.global_position + offsetFromPlayer
