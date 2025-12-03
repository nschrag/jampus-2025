class_name UpgradePool extends Node

@export var definitions: Array[UpgradeDefinition]
var def_map: Dictionary[String, UpgradeDefinition]
var pool: Array[String]

func _ready() -> void:
	for d in definitions:
		pool.append(d.id)
		def_map[d.id] = d
		
func select_set(count: int) -> Array[UpgradeDefinition]:
	var result: Array[UpgradeDefinition]
	pool.shuffle()
	for i in count:
		result.append(def_map[pool[i]])
	return result
