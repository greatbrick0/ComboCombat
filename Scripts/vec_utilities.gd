extends Node

func MouseWorldPos(cam: Camera3D) -> Vector2:
	var output: Vector2 = get_viewport().get_mouse_position()
	var posScale: float = 1080 / cam.size
	output -= Vector2(1920 / 2, 1080 / 2)
	output /= posScale
	output.y *= 1.41421
	output += Vector2(cam.global_position.x, cam.global_position.z - cam.global_position.y)
	return output

func ScreenPos(vec3: Vector3, cam: Camera3D) -> Vector2:
	var output: Vector2
	var posScale: float = 1080 / cam.size
	output.x = (vec3.x - cam.global_position.x) * posScale + (1920 / 2)
	output.y = (vec3.z - cam.global_position.z + cam.global_position.y) * posScale / 1.41421 + (1080 / 2)
	return output

func RoundToGrid(vec2: Vector2) -> Vector2:
	return Vector2(round(vec2.x * 8) / 8, round(vec2.y * 8) / 8)
