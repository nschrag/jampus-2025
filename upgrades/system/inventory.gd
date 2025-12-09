class_name Inventory extends Object

const months = [
	"January", "February", "March", "April", "May", "June", "July", 
	"August", "September", "October", "November", "December"]

var birth_month: int = 3
var current_month: int
var age: int = 18
var upgrades: Dictionary[String, int]
var wishes: Dictionary[String, float]
var breath_count: int = 0
var candle_colors: Array[Color]

func _init() -> void:
	current_month = birth_month
	
func advance_time():
	current_month = (current_month + 1) % months.size()
	if current_month == birth_month:
		age += 1
		
func is_birth_month() -> bool:
	return current_month == birth_month
	
func get_current_month_name() -> String:
	return months[current_month]

func has_wish(id: String):
	return wishes.has(id)
	
func increase_wish_chance(id: String, value: float):
	if wishes.has(id):
		wishes[id] += value
	else:
		wishes[id] = value
		
func does_wish_come_true(id: String) -> bool:
	if wishes.has(id):
		return randf() < wishes[id]
	else:
		return false

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
		
func get_candle_color() -> Color:
	if candle_colors.size() == 0:
		return Color.WHITE
	else:
		return candle_colors[randi_range(0, candle_colors.size() - 1)]
