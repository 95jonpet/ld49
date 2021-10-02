extends Area2D

const GRID_SIZE: Vector2 = Vector2(16, 16)

func _physics_process(delta: float) -> void:
	global_position = get_global_mouse_position().snapped(GRID_SIZE)  
