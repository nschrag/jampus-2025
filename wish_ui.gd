class_name WishUI extends Control

signal wish_selected

func _on_wish_selected(index: int):
	visible = false
	wish_selected.emit()
