extends Node3D

@export var flame: Node3D

func _on_mouse_entered_flame() -> void:
	flame.visible = false
