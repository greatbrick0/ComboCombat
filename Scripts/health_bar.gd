extends Node2D

@export var segments: int = 4
@export var displayedSegments: int = 3
@export var barWidth: float = 180
var dividers: PackedVector2Array = []

func _ready():
	pass

func UpdateValue(newHealth: int) -> void:
	displayedSegments = newHealth
	for ii in range(len(get_children())):
		if(segments - (ii*6) > 0):
			get_child(ii).value = 100 * (newHealth - (ii*6)) / min(segments - (ii*6), 6)

func SetUpSegments(count: int) -> void:
	displayedSegments = count
	for ii in range(len(get_children())):
		get_child(ii).size.x = barWidth
		get_child(ii).size.y = 9
		get_child(ii).position.x = -barWidth/2
		if(count > 0):
			get_child(ii).visible = true
			var barSegs: int = min(count, 6)
			for jj in barSegs - 1:
				dividers.append(Vector2(((jj + 1.0) / barSegs) * barWidth - (barWidth/2), 22 + (13*ii)))
				dividers.append(Vector2(((jj + 1.0) / barSegs) * barWidth - (barWidth/2), 33 + (13*ii)))
			count -= barSegs

func SetColour(newColour: Color) -> void:
	for ii in get_children():
		ii.material.set_shader_parameter("barColour", newColour)

func _draw():
	draw_multiline(dividers, Color("818181"), 3)
