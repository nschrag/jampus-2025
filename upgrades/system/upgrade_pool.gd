class_name UpgradePool extends Node

@export var definitions: Array[UpgradeDefinition]
static var definitions_dict: Dictionary[String, UpgradeDefinition]
var pool: Array[String]

func _ready() -> void:
	for d in definitions:
		pool.append(d.id)
		definitions_dict[d.id] = d
		
func select_set(count: int) -> Array[UpgradeDefinition]:
	var result: Array[UpgradeDefinition]
	pool.shuffle()
	for i in count:
		result.append(definitions_dict[pool[i]])
	return result
	
static func get_value(id: String, level: int) -> float:
	return definitions_dict[id].get_value(level)
