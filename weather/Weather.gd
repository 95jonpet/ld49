extends Node2D

const LIGHT_SKY_COLOR: Color = Color("#FFFFFF")
const DARK_SKY_COLOR: Color = Color("#241527")
const SKY_TRANSITON_TIME: int = 5

enum WeatherType {
	SUNNY,
	RAINY,
	SNOWY,
	NIGHT
}

var current_weather = WeatherType.SUNNY
onready var canvas_modulate: CanvasModulate = get_node("CanvasModulate")
onready var rain_particles: Particles2D = get_node("RainParticles")
onready var snow_particles: Particles2D = get_node("SnowParticles")
onready var tween: Tween = get_node("Tween")


func reset() -> void:
	canvas_modulate.color = LIGHT_SKY_COLOR
	set_weather(WeatherType.SUNNY)


func set_weather(weather_type) -> void:
	if weather_type == current_weather:
		return
	
	rain_particles.emitting = false
	snow_particles.emitting = false
	
	match weather_type:
		WeatherType.SUNNY:
			pass # No-op.
		WeatherType.RAINY:
			rain_particles.emitting = true
		WeatherType.SNOWY:
			snow_particles.emitting = true
	
	var is_ok = true
	if weather_type == WeatherType.NIGHT:
		is_ok = tween.interpolate_property(canvas_modulate, "color", canvas_modulate.color, DARK_SKY_COLOR, SKY_TRANSITON_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	else:
		is_ok = tween.interpolate_property(canvas_modulate, "color", canvas_modulate.color, LIGHT_SKY_COLOR, SKY_TRANSITON_TIME, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	assert(is_ok)
	is_ok = tween.start()
	assert(is_ok)
	
	current_weather = weather_type


func is_raining() -> bool:
	return current_weather == WeatherType.RAINY
