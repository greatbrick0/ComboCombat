extends Control

@export var managerNode: Node
@export var slot: int = 0
@export var selected: bool = false

@export var weapon: PackedScene
@export var weaponName: String = "Spear"
@export_multiline var weaponDesc: String = "Stabs a thin area forward. Combo: Larger spear."
@export var combo: Array[int] = [0, 0, 0]
@export var audioClip: AudioStream

func _ready():
	if(selected):
		PlayerSessionData.equipmentScenes[slot] = weapon
	
	if(audioClip):
		$AudioStreamPlayer.stream = audioClip

func _on_button_pressed():
	managerNode.SelectWeapon(slot, weaponName, weaponDesc, combo, weapon)
	if(!selected):
		$AudioStreamPlayer.play()
		selected = true

func _process(delta):
	$Button/SelectIndicator.visible = selected

func CancelSoundEffect() -> void:
	$AudioStreamPlayer.stop()
