class_name Seeder, "res://items/seeder.png"
extends Item

var current_seed: String = "carrots"
onready var label: Label = get_node("LabelPivot/Label")
onready var label_pivot: Node2D = get_node("LabelPivot")
onready var cabbage_scene: PackedScene = preload("res://crops/Cabbage.tscn")
onready var carrots_scene: PackedScene = preload("res://crops/Carrots.tscn")
onready var turnips_scene: PackedScene = preload("res://crops/Turnips.tscn")
onready var wheat_scene: PackedScene = preload("res://crops/Wheat.tscn")

func _ready() -> void:
	label.text = current_seed


func _process(_delta: float) -> void:
	# Ensure that the label is never flipped.
	label_pivot.scale.x = scale.x


func use_on_node(node: Node2D) -> void:
	if node.has_method("plant"):
		node.plant(_crop_from_seed(current_seed))


func _crop_from_seed(seed_name: String) -> Crop:
	match seed_name:
		"cabbage":
			return cabbage_scene.instance() as Crop
		"carrots":
			return carrots_scene.instance() as Crop
		"turnips":
			return turnips_scene.instance() as Crop
		"wheat":
			return wheat_scene.instance() as Crop
	
	print_debug("Unknown seed: " + seed_name)
	return wheat_scene.instance() as Crop


func _on_SeedPickupArea_body_shape_entered(_body_id: int, body: Node, _body_shape: int, _local_shape: int) -> void:
	if not visible:
		return
	
	if body.has_method("get_seed_name"):
		current_seed = body.get_seed_name()
		label.text = current_seed
