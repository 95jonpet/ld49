extends Node2D

func _ready() -> void:
	randomize()
	BackgroundMusic.play_music()
	Weather.reset()


func _on_WeatherTimer_timeout() -> void:
	var value: float = randf()
	if value < 0.25:
		Weather.set_weather(Weather.WeatherType.SNOWY)
	elif value < 0.5:
		Weather.set_weather(Weather.WeatherType.RAINY)
	elif value < 0.75:
		Weather.set_weather(Weather.WeatherType.NIGHT)
	else:
		Weather.set_weather(Weather.WeatherType.SUNNY)
