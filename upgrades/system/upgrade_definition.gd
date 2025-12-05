class_name UpgradeDefinition extends Resource

@export var id: String
@export var name: String
@export var levels: Array[float]
@export var description: String
	
func get_value(level: int):
	if levels.size() == 0:
		push_error("No levels defined")
		
	if levels.size() <= level:
		push_warning("Exceeded max level")
		level = levels.size() - 1
		
	return levels[level]
