extends ColorRect

func _on_ready_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
