extends StaticBody2D

export(String) var seed_name: String

onready var label: Label = get_node("LabelPosition/Label")

func _ready() -> void:
	label.text = seed_name


func get_seed_name() -> String:
	return seed_name
