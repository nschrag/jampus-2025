class_name UpgradeDefinition extends Resource

@export var id: String
@export var name: String
@export var description: String
@export var max_level: int
@export var max_value: float
@export var curve: Tween.TransitionType = Tween.TransitionType.TRANS_LINEAR
@export var curve_ease: Tween.EaseType = Tween.EaseType.EASE_OUT
@export var levels: Array[float]

func get_value(level: int):
	assert(level <= max_level)
	level = min(level, max_level) # hack just make sure it's not over max level
	return Tween.interpolate_value(0, max_value, level, max_level, curve, curve_ease)
	
func _get_value(level: int):
	if levels.size() == 0:
		push_error("No levels defined")
		
	if levels.size() <= level:
		push_warning("Exceeded max level")
		level = levels.size() - 1
		
	return levels[level]
