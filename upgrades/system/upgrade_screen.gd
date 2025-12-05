class_name UpgradeScreen extends Control

signal upgrade_selected(id: String)

@export var month_label: Label
var panels: Array[UpgradePanel]

func _ready() -> void:
	for c: UpgradePanel in $HBoxContainer.get_children():
		panels.append(c)
		c.selected.connect(_on_selected)

func populate(inventory: Inventory, upgrades: Array[UpgradeDefinition]):
	month_label.text = inventory.get_current_month_name()
	for i in upgrades.size():
		panels[i].populate(inventory.get_upgrade_level(upgrades[i].id) + 1, upgrades[i])

func _on_selected(id: String):
	self.visible = false
	upgrade_selected.emit(id)
