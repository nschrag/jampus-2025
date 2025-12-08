class_name Birthday extends Node3D

@export var candle_spawner: CandleSpawner
@export var noise: FastNoiseLite
@export var lights: Array[OmniLight3D]
@export var light_energy: float = 2

signal celebration_complete
	
func _on_all_candles_extinguished():
	celebration_complete.emit()
	
func _process(delta: float) -> void:
	for i in lights.size():
		var n1 = noise.get_noise_2d(i, Time.get_ticks_msec() / 20.0)
		lights[i].light_energy = light_energy + n1
		lights[i].position.x = \
			noise.get_noise_2d(i + lights.size(), Time.get_ticks_msec() / 40.0) * 0.1
		lights[i].position.y = \
			noise.get_noise_2d(i + lights.size() * 2, Time.get_ticks_msec() / 40.0) * 0.1
