class_name UpgradeScreen extends Control

var panels: Array[UpgradePanel]

func _ready() -> void:
	for c in $HBoxContainer.get_children():
		panels.append(c)

func populate(inventory: Inventory, upgrades: Array[UpgradeDefinition]):
	for i in upgrades.size():
		var lambda = func():
			inventory.upgrade(upgrades[i].id)
			selected(upgrades[i].id)
			
		panels[i].pressed.connect(lambda, ConnectFlags.CONNECT_ONE_SHOT)
		panels[i].populate(inventory.get_upgrade_level(upgrades[i].id) + 1, upgrades[i])

func selected(id: String):
	self.visible = false
