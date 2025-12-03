class_name UpgradeScreen extends Control

var panels: Array[UpgradePanel]

func _ready() -> void:
	for c in $HBoxContainer.get_children():
		panels.append(c)

func populate(upgrades: Array[UpgradeDefinition]):
	for i in upgrades.size():
		panels[i].populate(upgrades[i])
