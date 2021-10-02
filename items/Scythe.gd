class_name Scythe
extends AnimatedSprite

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var area2d: Area2D = get_node("Area2D")

func harvest_crops() -> void:
	for area in area2d.get_overlapping_areas():
		if area.has_method("harvest"):
			area.harvest()


func sweep() -> void:
	if animation_player.is_playing():
		return
	
	animation_player.play("sweep")
