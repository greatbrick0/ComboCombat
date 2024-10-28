extends Node3D
class_name UiTracker

var trackPos: bool = true

@export var trackerObj: PackedScene
var instance: Node

func _enter_tree():
	CreateUi()

func _exit_tree():
	DeleteUi()

func CreateUi() -> void:
	instance = trackerObj.instantiate()
	get_tree().root.add_child.call_deferred(instance)

func DeleteUi() -> void:
	instance.queue_free()

func _process(delta):
	if(trackPos):
		var posScale = 720 / get_viewport().get_camera_3d().size
		instance.global_position.x = global_position.x * posScale + (1280 / 2)
		instance.global_position.y = global_position.z * posScale / 1.41421 + (720 / 2)
