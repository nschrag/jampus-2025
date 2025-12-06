class_name Candle extends Node3D

signal flame_extinguished

@export var flame: Sprite3D
@export var collider: Area3D
var resilience: float = 0.5

var timer: Timer
const _hack_flame_radius = 30

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(extinguish)
	add_child(timer)
	
func check_overlap(camera:Camera3D, pos:Vector2, radius: float):
	if not flame.visible:
		return
		
	var flame_pos = camera.unproject_position(flame.global_position)
	if pos.distance_to(flame_pos) <= radius + _hack_flame_radius:
		if timer.is_stopped():
			timer.start(resilience)
	else:
		timer.stop()

func extinguish():
	assert(flame.visible)
	collider.monitoring = false
	flame.visible = false
	flame_extinguished.emit()
