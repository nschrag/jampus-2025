extends Node

var birthday_scene = preload("uid://boq5qh4017at0")
var upgrade_scene = preload("uid://c6u3781fh0apv")
@export var upgrade_pool: UpgradePool

const months = [
	"January", "February", "March", "April", "May", "June", "July", 
	"August", "September", "October", "November", "December"]

var current_month = 0
var inventory: Inventory
var bday: Birthday
var upgrade_screen: UpgradeScreen

func _ready() -> void:
	inventory = Inventory.new()
	current_month = inventory.birth_month

	bday = birthday_scene.instantiate()
	bday.celebration_complete.connect(_on_celebration_complete)
	add_child(bday)
	
	upgrade_screen = upgrade_scene.instantiate()
	upgrade_screen.upgrade_selected.connect(_on_upgrade_selected)
	add_child(upgrade_screen)
	
	begin_celebration()
	
func begin_celebration():
	upgrade_screen.visible = false
	bday.candle_spawner.clear_candles()
	bday.candle_spawner.spawn_candles(inventory, inventory.age - 17)
	
func _on_celebration_complete():
	upgrade_screen.visible = true
	upgrade_screen.populate(inventory, upgrade_pool.select_set(3))
	
func _on_upgrade_selected(id: String):
	inventory.upgrade(id)
	current_month = (current_month + 1) % months.size()
	if current_month == inventory.birth_month:
		inventory.age += 1
		begin_celebration()
	else:
		_on_celebration_complete()
