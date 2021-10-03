class_name Shovel, "res://items/shovel.png"
extends Item

onready var plot_scene = preload("res://crops/Plot.tscn")
onready var plots: Node2D = get_node("../../../Plots")

func use_on_free(pos: Vector2) -> void:
	var plot: Plot = plot_scene.instance()
	plot.global_position = pos
	plots.add_child(plot)
