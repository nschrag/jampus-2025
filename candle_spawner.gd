extends Node3D

@onready var candle_scene = preload("res://candle.tscn")

var inventory: Inventory

func _init() -> void:
	inventory = Inventory.new()
	
func _ready() -> void:
	spawn_candles.call_deferred(10)

func spawn_candles(number: int):
	for i in number:
		var p = random_in_circle(0.25)
		var c: Candle = candle_scene.instantiate()
		add_child(c)
		c.position = Vector3(p.x, 0, p.y)
		c.resilience -= inventory.get_upgrade_value("flame_resilience")

func random_in_circle(radius: float) -> Vector2:
	var r = radius * sqrt(randf())
	var theta = 2 * PI * randf()
	var point = Vector2(r * cos(theta), r * sin(theta))
	return point
	
	
