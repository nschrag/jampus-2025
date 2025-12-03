class_name UpgradeDefinition extends Resource

static var definitions: Dictionary[String, UpgradeDefinition]

@export var id: String
@export var name: String
@export var levels: Array[float]


func _init() -> void:
	definitions[id] = self
	
func get_value(level: int):
	if levels.size() == 0:
		push_error("No levels defined")
		
	if levels.size() <= level:
		push_warning("Exceeded max level")
		level = levels.size() - 1
		
	return levels[level]
