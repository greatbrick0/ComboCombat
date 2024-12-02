extends Node3D
class_name UiTracker

var trackPos: bool = true

@export var trackerObj: PackedScene
var instance: Node
signal CreatedElement(element: Node)

func _enter_tree():
	CreateUi()

func _exit_tree():
	DeleteUi()

func CreateUi() -> void:
	instance = trackerObj.instantiate()
	get_tree().root.get_node("Node/FlatElements").add_child.call_deferred(instance)
	instance.ready.connect(ElementIsReady)

func DeleteUi() -> void:
	instance.queue_free()

func ElementIsReady():
	emit_signal("CreatedElement", instance)

func _process(delta):
	if(trackPos):
		instance.global_position = VecUtilities.ScreenPos(global_position, get_viewport().get_camera_3d())
