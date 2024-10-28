extends MeshInstance3D

func _process(delta):
	if(Input.is_action_pressed("ui_up")):
		position += Vector3.FORWARD * delta
	if(Input.is_action_pressed("ui_down")):
		position += Vector3.BACK * delta
	if(Input.is_action_pressed("ui_left")):
		position += Vector3.LEFT * delta
	if(Input.is_action_pressed("ui_right")):
		position += Vector3.RIGHT * delta
