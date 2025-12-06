extends Control

@export var cursor: Control
var cursor_radius = 25

func _process(delta: float) -> void:
	position = get_global_mouse_position()
	
	var camera: Camera3D = get_viewport().get_camera_3d()
	for candle: Candle in get_tree().get_nodes_in_group("candle"):
		candle.check_overlap(camera, position, cursor_radius)
	
func _draw():
	draw_circle(position, cursor_radius, Color.SKY_BLUE)
	#var camera: Camera3D = get_viewport().get_camera_3d()
	#for candle: Candle in get_tree().get_nodes_in_group("candle"):
		#draw_circle(camera.unproject_position(candle.get_flame_pos()), 10, Color.SKY_BLUE, false)
