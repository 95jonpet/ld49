extends Area2D

onready var tile_map: TileMap = get_node("../TileMap")
onready var player: Player = get_node("../Player")
onready var wheat_scene: PackedScene = preload("res://crops/Wheat.tscn")

var tile_position: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	var player_tile_position := tile_map.world_to_map(player.global_position)
	tile_position = player_tile_position + Vector2(player.facing_direction, 0)
	global_position = tile_map.map_to_world(tile_position)


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_action"):
		return
	
	for area in get_overlapping_areas():
		if area.has_method("plant"):
			area.plant(wheat_scene.instance())
		if area.has_method("harvest"):
			area.harvest()
