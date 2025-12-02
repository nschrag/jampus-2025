extends Node

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("quit") && event.is_released():
		get_tree().quit()
