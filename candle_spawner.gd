class_name CandleSpawner extends Node3D

@onready var candle_scene = preload("uid://dyvac0uqplsu3")

signal all_candles_extinguished

var burning_candle_count: int = 0

func spawn_candles(inventory: Inventory, count: int):
	burning_candle_count = count
	for i in count:
		var p = random_in_circle(0.25)
		var c: Candle = candle_scene.instantiate()
		add_child(c)
		c.position = Vector3(p.x, 0, p.y)
		c.resilience -= inventory.get_upgrade_value("flame_resilience")
		c.flame_extinguished.connect(_on_candle_extinguished)
		
func clear_candles():
	for c in get_children():
		c.queue_free()
		
func _on_candle_extinguished():
	burning_candle_count -= 1
	if burning_candle_count == 0:
		all_candles_extinguished.emit()
		

func random_in_circle(radius: float) -> Vector2:
	var r = radius * sqrt(randf())
	var theta = 2 * PI * randf()
	var point = Vector2(r * cos(theta), r * sin(theta))
	return point
	
	
