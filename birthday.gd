class_name Birthday extends Node3D

signal celebration_complete
	
func _on_all_candles_extinguished():
	celebration_complete.emit()
