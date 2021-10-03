class_name Item
extends Node2D

onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")

func move(facing_direction: int) -> void:
	assert(facing_direction == 1 or facing_direction == -1)
	scale.x = facing_direction


func is_ready() -> bool:
	return not animation_player.is_playing()


func use_on_free(_position: Vector2) -> void:
	pass


func use_on_node(_node: Node2D) -> void:
	pass
