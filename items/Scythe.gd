class_name Scythe, "res://items/scythe.png"
extends Item

func use_on_node(node: Node2D) -> void:
	if node.has_method("harvest"):
		animation_player.play("harvest")
		node.harvest()
	elif node.has_method("destroy"):
		animation_player.play("destroy")
		node.destroy()
