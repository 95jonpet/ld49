class_name Scythe, "res://items/scythe.png"
extends Item

func use_on_node(node: Node2D) -> void:
	if not node.has_method("harvest"):
		return
	node.harvest()
