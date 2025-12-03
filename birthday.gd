class_name Birthday extends Node3D

@export var candle_spawner: CandleSpawner

signal celebration_complete
	
func _on_all_candles_extinguished():
	celebration_complete.emit()
