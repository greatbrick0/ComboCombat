extends Camera3D

@export var offsetFromPlayer: Vector3
var playerRef: Node3D

func _process(delta):
	global_position = playerRef.global_position + offsetFromPlayer
