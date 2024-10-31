extends Node2D

@export var segments: int = 4

func _ready():
	for ii in range(len(get_children())):
		get_child(ii).visible = segments/6 >= ii
