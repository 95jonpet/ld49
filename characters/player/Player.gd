extends Character

onready var cursor: Area2D = get_node("Cursor")
onready var light: Light2D = get_node("Light2D")
onready var item_position: Position2D = get_node("ItemPosition")
onready var scythe: Scythe = get_node("Hand/Scythe")

func _process(_delta: float) -> void:
	light.enabled = Weather.current_weather == Weather.WeatherType.NIGHT
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and animated_sprite.flip_h:
		animated_sprite.flip_h = false
		item_position.scale.x = 1
	elif mouse_direction.x < 0 and not animated_sprite.flip_h:
		animated_sprite.flip_h = true
		item_position.scale.x = -1


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


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_harvest"):
		scythe.sweep()
