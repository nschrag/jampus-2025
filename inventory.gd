class_name Inventory extends Object

var age: int
var upgrades: Dictionary[String, int]

func get_upgrade_level(id: String) -> int:
	if upgrades.has(id):
		return upgrades[id]
	else:
		return 0
		
func get_upgrade_value(id: String) -> float:
	if upgrades.has(id):
		return UpgradeDefinition.definitions[id].levels[upgrades[id]]
	else:
		return 0
