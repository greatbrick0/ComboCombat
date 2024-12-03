extends ColorRect

@export var comboStepDisplayColour: Color
@export var comboStepDisplayRef: PackedScene
var comboStepDisplayInstance: Node2D

func _on_ready_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainScene.tscn")
	MusicManager.PlayGeneral(0)

func _on_quit_button_pressed():
	get_tree().quit()

func SelectWeapon(column: int, wName: String, wDesc: String, wCombo: Array[int], wScene: PackedScene) -> void:
	$Description.visible = true
	$Description/VBoxContainer/WeaponTitle.text = wName
	$Description/VBoxContainer/ComboLabel.visible = column != 1
	$Description/VBoxContainer/ComboPanel.visible = column != 1
	for ii in $Description/VBoxContainer/ComboPanel/Centre.get_children():
		ii.queue_free()
	for ii in len(wCombo):
		comboStepDisplayInstance = comboStepDisplayRef.instantiate()
		$Description/VBoxContainer/ComboPanel/Centre.add_child(comboStepDisplayInstance)
		comboStepDisplayInstance.DisplayStep(wCombo[ii])
		comboStepDisplayInstance.position.x = -(60 * len(wCombo) * 0.5) + (60 * ii + 30)
		comboStepDisplayInstance.SetColour(comboStepDisplayColour)
	$Description/VBoxContainer/DescriptionPanel/Label.text = wDesc
	for ii in [2, 3, 4]:
		for jj in 3:
			$Selectors/HBoxContainer.get_child(jj).get_child(ii).CancelSoundEffect()
		if($Selectors/HBoxContainer.get_child(column).get_child(ii).weaponName != wName):
			$Selectors/HBoxContainer.get_child(column).get_child(ii).selected = false
	PlayerSessionData.equipmentScenes[column] = wScene
