extends Node

func MouseWorldPos(cam: Camera3D) -> Vector2:
	var output: Vector2 = get_viewport().get_mouse_position()
	var posScale: float = 720 / cam.size
	output -= Vector2(1280 / 2, 720 / 2)
	output /= posScale
	output.y *= 1.41421
	return output

func ScreenPos(vec3: Vector3, cam: Camera3D) -> Vector2:
	var output: Vector2
	var posScale: float = 720 / cam.size
	output.x = vec3.x * posScale + (1280 / 2)
	output.y = vec3.z * posScale / 1.41421 + (720 / 2)
	return output

func RoundToGrid(vec2: Vector2) -> Vector2:
	return Vector2(round(vec2.x * 8) / 8, round(vec2.y * 8) / 8)
