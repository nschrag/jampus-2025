class_name Inventory extends Object

var birth_month: int = 3
var age: int = 18
var upgrades: Dictionary[String, int]

func upgrade(id: String):
	if upgrades.has(id):
		upgrades[id] += 1
	else:
		upgrades[id] = 1

func get_upgrade_level(id: String) -> int:
	if upgrades.has(id):
		return upgrades[id]
	else:
		return 0
		
func get_upgrade_value(id: String) -> float:
	if upgrades.has(id):
		return UpgradePool.get_value(id, upgrades[id])
	else:
		return 0
