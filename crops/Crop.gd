class_name Crop
extends Area2D

signal harvested(crop)

export(int) var growth_time: int = 100 # Ticks required to grow.
var growth_progress: int = 0
var hydrated: bool = false

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")

func can_grow() -> bool:
	return growth_progress < growth_time && hydrated


func can_harvest() -> bool:
	return growth_progress == growth_time


func grow() -> void:
	if growth_progress == growth_time:
		return
	
	growth_progress = int(min(growth_progress + 1, growth_time))
	animated_sprite.frame = int(floor((float(growth_progress) / float(growth_time)) * (animated_sprite.frames.get_frame_count("default") - 1)))


func harvest() -> void:
	if not can_harvest():
		return
	
	get_node("/root/Gui").add_score(growth_time)
	emit_signal("harvested", self)
	queue_free()


func _on_GrowthTickTimer_timeout() -> void:
	if can_grow():
		grow()
