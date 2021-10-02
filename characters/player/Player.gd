class_name Player
extends Character

onready var light: Light2D = get_node("Light2D")

var facing_direction: int = 1 # left = 1, right = -1.

func _process(_delta: float) -> void:
	Weather.global_position = global_position
	light.enabled = Weather.current_weather == Weather.WeatherType.NIGHT
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		facing_direction = 1
		animated_sprite.flip_h = false
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		facing_direction = -1
		animated_sprite.flip_h = true


func handle_input() -> void:
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP
