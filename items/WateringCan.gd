extends AnimatedSprite

onready var area2d: Area2D = get_node("Area2D")


func _on_Timer_timeout() -> void:
	for area in area2d.get_overlapping_areas():
		if area.has_method("water"):
			area.water()
