extends Node

var birthday_scene = preload("uid://boq5qh4017at0")
var upgrade_scene = preload("uid://c6u3781fh0apv")
@export var upgrade_pool: UpgradePool
@export var breath_cursor: BreathCursor

var inventory: Inventory
var bday: Birthday
var upgrade_screen: UpgradeScreen

func _ready() -> void:
	inventory = Inventory.new()
	
	breath_cursor.inventory = inventory

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

func begin_upgrade():
	upgrade_screen.visible = true
	upgrade_screen.populate(inventory, upgrade_pool.select_set(3))
	
func _on_celebration_complete():
	inventory.advance_time()
	begin_upgrade()
	
func _on_upgrade_selected(id: String):
	inventory.upgrade(id)
	inventory.advance_time()
	if inventory.is_birth_month():
		begin_celebration()
	else:
		begin_upgrade()
