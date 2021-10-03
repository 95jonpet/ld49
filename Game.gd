class_name Game
extends Node2D

const GRID_SIZE: int = 16
const WORLD_START: int = -192
const WORLD_END: int = 176
const MIN_SQUARED_DISTANCE_TO_PLAYER: int = 64 * 64

onready var player: Player = get_node("Player")
onready var stone_scene: PackedScene = preload("res://world/Stone.tscn")
onready var stones: Node2D = get_node("Stones")
onready var tile_map: TileMap = get_node("TileMap")

func _ready() -> void:
	randomize()
	BackgroundMusic.play_music()
	Weather.reset()


func _on_WeatherTimer_timeout() -> void:
	var value: float = randf()
	if value < 0.25:
		Weather.set_weather(Weather.WeatherType.SNOWY)
	elif value < 0.5:
		Weather.set_weather(Weather.WeatherType.RAINY)
	elif value < 0.75:
		Weather.set_weather(Weather.WeatherType.NIGHT)
	else:
		Weather.set_weather(Weather.WeatherType.SUNNY)


func _on_StoneTimer_timeout() -> void:
	for _i in range(10):
		var world_pos := Vector2(int(rand_range(WORLD_START, WORLD_END)), int(rand_range(WORLD_START, WORLD_END))).snapped(Vector2.ONE * GRID_SIZE)
		var map_pos := tile_map.world_to_map(world_pos)
		
		if tile_map.get_cellv(map_pos) != 0: # Not on grass tile.
			continue
		
		# Free from the player.
		if world_pos.distance_squared_to(player.global_position) < MIN_SQUARED_DISTANCE_TO_PLAYER:
			continue
		
		var stone: Node2D = stone_scene.instance()
		stone.global_position = world_pos
		stones.add_child(stone)
		break
