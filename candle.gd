class_name Candle extends Node3D

signal flame_extinguished

@export var flame: Node3D
var resilience: float = 0.5

var timer: Timer

func extinguish():
	flame.visible = false
	flame_extinguished.emit()

func _on_mouse_entered_flame() -> void:
	if timer == null:
		timer = Timer.new()
		timer.timeout.connect(extinguish)
		add_child(timer)
	
	timer.start(resilience)

func _on_mouse_exited_flame() -> void:
	timer.stop()
