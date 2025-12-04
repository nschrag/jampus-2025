class_name Candle extends Node3D

signal flame_extinguished

@export var flame: Node3D
@export var collider: Area3D
var resilience: float = 0.5

var timer: Timer

func extinguish():
	assert(flame.visible)
	collider.monitoring = false
	flame.visible = false
	flame_extinguished.emit()

func _on_mouse_entered_flame() -> void:
	if timer == null:
		timer = Timer.new()
		timer.one_shot = true
		timer.timeout.connect(extinguish)
		add_child(timer)
	
	timer.start(resilience)

func _on_mouse_exited_flame() -> void:
	timer.stop()
