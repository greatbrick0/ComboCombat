extends Node3D

@export var playerScene: PackedScene
var playerInstance: Node3D

func _ready():
	playerInstance = playerScene.instantiate()
	add_child(playerInstance)
	playerInstance.get_node("MovementHolder").add_child(PlayerSessionData.equipmentScenes[1].instantiate())
	playerInstance.get_node("LeftWeaponHolder").add_child(PlayerSessionData.equipmentScenes[0].instantiate())
	playerInstance.get_node("RightWeaponHolder").add_child(PlayerSessionData.equipmentScenes[2].instantiate())
	playerInstance.Initialize()
	$ControlledCamera.playerRef = playerInstance
	$ControlledCamera.offsetFromPlayer = $ControlledCamera.global_position - playerInstance.global_position
