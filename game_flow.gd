extends Node

var birthday_scene = preload("uid://boq5qh4017at0")
var upgrade_scene = preload("uid://c6u3781fh0apv")
@export var upgrade_pool: UpgradePool
@export var breath_cursor: BreathCursor
@export var wish_ui: WishUI

var inventory: Inventory
var bday: Birthday
var upgrade_screen: UpgradeScreen

const debug_age_adjust = 0

func _ready() -> void:
	inventory = Inventory.new()
	
	breath_cursor.inventory = inventory

	bday = birthday_scene.instantiate()
	bday.celebration_complete.connect(_on_celebration_complete)
	add_child(bday)
	
	upgrade_screen = upgrade_scene.instantiate()
	upgrade_screen.upgrade_selected.connect(_on_upgrade_selected)
	add_child(upgrade_screen)
	
	wish_ui.wish_selected.connect(_on_wish_selected)
	
	begin_celebration()
	
func begin_celebration():
	upgrade_screen.visible = false
	breath_cursor.process_mode = Node.PROCESS_MODE_DISABLED
	inventory.breath_count = 0
	bday.candle_spawner.clear_candles()
	bday.candle_spawner.spawn_candles(inventory, inventory.age - debug_age_adjust)
	wish_ui.visible = true

func begin_upgrade():
	breath_cursor.process_mode = Node.PROCESS_MODE_DISABLED
	upgrade_screen.visible = true
	upgrade_screen.populate(inventory, upgrade_pool.select_set(3))
	
func _on_celebration_complete():
	print(inventory.age / float(inventory.breath_count))
	inventory.advance_time()
	begin_upgrade()
	
func _on_wish_selected():
	wish_ui.visible = false
	breath_cursor.process_mode = Node.PROCESS_MODE_INHERIT
	
func _on_upgrade_selected(id: String):
	inventory.upgrade(id)
	inventory.advance_time()
	if inventory.is_birth_month():
		begin_celebration()
	else:
		begin_upgrade()
