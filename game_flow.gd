extends Node

var birthday_scene = preload("uid://boq5qh4017at0")
var upgrade_scene = preload("uid://c6u3781fh0apv")
@export var upgrade_pool: UpgradePool

var inventory: Inventory
var bday: Birthday
var upgrade_screen: UpgradeScreen

func _ready() -> void:
	inventory = Inventory.new()

	bday = birthday_scene.instantiate()
	bday.celebration_complete.connect(_on_celebration_complete)
	add_child(bday)
	bday.candle_spawner.spawn_candles(inventory, 1)
	
	upgrade_screen = upgrade_scene.instantiate()
	upgrade_screen.visible = false
	add_child(upgrade_screen)
	
func _on_celebration_complete():
	upgrade_screen.visible = true
	upgrade_screen.populate(inventory, upgrade_pool.select_set(3))
