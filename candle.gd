class_name Candle extends Node3D

signal flame_extinguished

@export var flame: Sprite3D
@export var collider: Area3D
@export var flame_shader: ColorRect
var resilience: float = 0.5

var timer: Timer
const _hack_flame_radius = 30

func _ready() -> void:
	timer = Timer.new()
	timer.one_shot = true
	timer.timeout.connect(extinguish)
	add_child(timer)
	
	flame_shader.set_instance_shader_parameter("flicker_offset", randf() * 0.5)
	flame_shader.set_instance_shader_parameter("flicker_period", randf_range(1.8, 2.2) * 0.5)
	
func _process(_delta: float) -> void:
	if timer.is_stopped():
		flame.scale.y = 1.0
	else:
		flame.scale.y = 0.7 + 0.3 * (timer.time_left / resilience)
	
func check_overlap(blowing: bool, camera:Camera3D, pos:Vector2, radius: float):
	if not flame.visible:
		return
		
	if not blowing:
		timer.stop()
		return
		
	var flame_pos = camera.unproject_position(flame.global_position)
	if pos.distance_to(flame_pos) <= radius + _hack_flame_radius:
		if resilience <= 0.05:
			extinguish.call_deferred()
		if timer.is_stopped():
			timer.start(resilience)
	else:
		timer.stop()

func extinguish():
	assert(flame.visible)
	collider.monitoring = false
	flame.visible = false
	flame_extinguished.emit()
	
var neighbors: Array[Candle]
func calc_distance_score(candles: Array[Node]):
	for c: Candle in candles:
		var d = flame.global_position.distance_squared_to(c.flame.global_position)
		if d < .8:
			neighbors.push_back(c)
		
	print(neighbors.size())
