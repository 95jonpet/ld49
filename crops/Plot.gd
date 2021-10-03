class_name Plot
extends StaticBody2D

const HYDRATION_LOSS_PER_SECOND: float = 0.0075
const RAIN_HYDRATION_PER_SECOND: float = 0.05
const WATERING_HYDRATION: float = 1.0

export(float) var hydration: float = 0.35

var crop: Crop = null
onready var animated_sprite: AnimatedSprite = get_node("AnimatedSprite")
onready var animation_player: AnimationPlayer = get_node("AnimationPlayer")
onready var crop_position: Position2D = get_node("CropPosition")


func harvest() -> void:
	if not crop:
		return
	
	crop.harvest()

func plant(new_crop: Crop) -> void:
	if crop_position.get_child_count() != 0:
		return
	animation_player.play("plant")
	crop_position.add_child(new_crop)
	new_crop.position = Vector2.ZERO
	
	var error = new_crop.connect("harvested", self, "_on_Crop_harvested_event")
	assert(error == OK)
	crop = new_crop


func water() -> void:
	hydration = min(hydration + WATERING_HYDRATION, 1)


func _process(delta: float) -> void:
	if Weather.is_raining():
		hydration = min(hydration + RAIN_HYDRATION_PER_SECOND * delta, 1)
	
	animated_sprite.frame = int(floor(hydration * animated_sprite.frames.get_frame_count("default")))
	
	if crop:
		crop.hydrated = hydration >= 0.5
		hydration = max(hydration - HYDRATION_LOSS_PER_SECOND * delta, 0)


func _on_Crop_harvested_event(_crop: Crop) -> void:
	crop = null
	animation_player.play("harvest")


func _on_Timer_timeout() -> void:
	if animated_sprite.frame != 0: # Not totally dried out
		return
	
	if randf() < 0.2:
		queue_free()
