class_name BreathCursor extends Control

@export var cursor_color: Color
var cursor_color_opaque: Color
var cursor_radius = 25
var breath_fill_fraction: float = 0
var breath_rate = 0
var inventory: Inventory

func get_effective_breath_rate() -> float:
	if breath_rate == 0:
		return breath_rate
	elif breath_rate < 0:
		return breath_rate + inventory.get_upgrade_value("exhale_rate")
	else:
		return breath_rate + inventory.get_upgrade_value("inhale_rate")

func _ready() -> void:
	cursor_color_opaque = cursor_color
	cursor_color_opaque.a = 1
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	var new_value = clampf(breath_fill_fraction + delta * get_effective_breath_rate(), 0, 1)
	if breath_fill_fraction != new_value:
		breath_fill_fraction = new_value
		queue_redraw()
		
		if breath_fill_fraction == 0:
			breath_rate = 0
			
	# Blow out candles only while exhaling
	var camera: Camera3D = get_viewport().get_camera_3d()
	for candle: Candle in get_tree().get_nodes_in_group("candle"):
		candle.check_overlap(breath_rate == -1, camera, position, cursor_radius)
		
func _draw():
	draw_circle(Vector2.ZERO, cursor_radius * breath_fill_fraction, cursor_color)
	draw_circle(Vector2.ZERO, cursor_radius, cursor_color_opaque, false)
	#var camera: Camera3D = get_viewport().get_camera_3d()
	#for candle: Candle in get_tree().get_nodes_in_group("candle"):
		#draw_circle(camera.unproject_position(candle.get_flame_pos()), 10, Color.SKY_BLUE, false)
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("breathe"):
		breath_rate = 1
		
	if event.is_action_released("breathe"):
		breath_rate = -1
