extends Node

var birthday_scene = preload("uid://boq5qh4017at0")
var upgrade_scene = preload("uid://c6u3781fh0apv")

func _ready() -> void:
	var bday: Birthday = birthday_scene.instantiate()
	bday.celebration_complete.connect(_on_celebration_complete)
	add_child(bday)
	
func _on_celebration_complete():
	add_child(upgrade_scene.instantiate())
