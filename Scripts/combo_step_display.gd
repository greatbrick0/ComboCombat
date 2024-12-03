extends Node2D

func DisplayStep(stepType: int) -> void:
	for ii in range(get_child_count()):
		get_child(ii).visible = ii == stepType

func SetColour(newColour: Color) -> void:
	modulate = newColour
