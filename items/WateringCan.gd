class_name WateringCan, "res://items/watering_can.png"
extends Item

func use_on_free(_position: Vector2) -> void:
	animation_player.play("use")


func use_on_node(node: Node2D) -> void:
	animation_player.play("use")
	if node.has_method("water"):
		node.water()
