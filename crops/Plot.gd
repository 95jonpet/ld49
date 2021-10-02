class_name Plot
extends Area2D

const RAIN_HYDRATION_PER_SECOND: float = 0.05
const WATERING_HYDRATION: float = 0.05

export(float) var hydration: float = 0

onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var crop_position: Position2D = get_node("CropPosition")
onready var wheat_scene: PackedScene = preload("res://crops/Wheat.tscn")

func plant(crop: Crop) -> void:
	if crop_position.get_child_count() != 0:
		return
	animation_player.play("plant")
	crop_position.add_child(crop)
	crop.position = Vector2.ZERO
	
	var error = crop.connect("harvested", self, "_on_Crop_harvested_event")
	assert(error == OK)


func water() -> void:
	hydration = min(hydration + WATERING_HYDRATION, 1)


func _process(delta: float) -> void:
	if Weather.is_raining():
		hydration = min(hydration + RAIN_HYDRATION_PER_SECOND * delta, 1)
	
	animated_sprite.frame = int(floor(hydration * (animated_sprite.frames.get_frame_count("default") - 1)))


func _on_Crop_harvested_event(_crop: Crop) -> void:
	animation_player.play("harvest")


func _on_Plot_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			plant(wheat_scene.instance())
