class_name Stone, "res://world/stone.png"
extends StaticBody2D

func destroy() -> void:
	queue_free()
