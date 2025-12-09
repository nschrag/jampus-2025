class_name WishUI extends Control

signal wish_selected(wish: WishDefinition)

@export var wishes: Array[WishDefinition]
@export var wish_a: Button
@export var wish_b: Button
var wish_options: Array[WishDefinition]

func select_wishes(inventory: Inventory):
	var list: Array[int]
	var a: WishDefinition = null
	var b: WishDefinition = null
	for i in min(inventory.get_upgrade_value("bold_wish"), wishes.size()):
		list.push_back(roundi(i))
	list.shuffle()
	for i in list:
		if a == null && inventory.has_wish(wishes[i].id):
			a = wishes[i]
		if b == null && not inventory.has_wish(wishes[i].id):
			b = wishes[i]
			
	if a == null:
		a = wishes[randi_range(0, 1)]
	if b == null:
		b = wishes[randi_range(2, 3)]
	
	wish_a.text = "%s (%.1f%%)" % [a.description, inventory.get_wish_chance(a.id)]
	wish_b.text = "%s (%.1f%%)" % [b.description, inventory.get_wish_chance(b.id)]
	
	wish_options = [a, b]

func _on_wish_selected(index: int):
	visible = false
	wish_selected.emit(wish_options[index])
