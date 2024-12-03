extends Node3D

@export var playerScene: PackedScene
var playerInstance: Node3D

@export var enemyTypes: Array[PackedScene]
var enemyInstance: Enemy
var enemyCount: int = 0

func _ready():
	playerInstance = playerScene.instantiate()
	add_child(playerInstance)
	playerInstance.get_node("MovementHolder").add_child(PlayerSessionData.equipmentScenes[1].instantiate())
	playerInstance.get_node("LeftWeaponHolder").add_child(PlayerSessionData.equipmentScenes[0].instantiate())
	playerInstance.get_node("RightWeaponHolder").add_child(PlayerSessionData.equipmentScenes[2].instantiate())
	playerInstance.Initialize(get_tree().root.get_node("MainScene/PlayerHud"))
	$ControlledCamera.playerRef = playerInstance
	$ControlledCamera.offsetFromPlayer = $ControlledCamera.global_position - playerInstance.global_position
	
	SpawnEnemy(Vector3.RIGHT * 5)
	SpawnEnemy(Vector3.LEFT * 5)
	SpawnEnemy(Vector3.FORWARD * 5)

func SpawnEnemy(spawnPos: Vector3, typeIndex: int = 0) -> void:
	enemyInstance = enemyTypes[typeIndex].instantiate()
	add_child(enemyInstance)
	enemyInstance.global_position = spawnPos
	enemyInstance.died.connect(EnemyDied)
	enemyCount += 1

func EnemyDied() -> void:
	print("died")
	enemyCount -= 1
	if(enemyCount == 0):
		MusicManager.ChangeTrack(0)
		print("win")
