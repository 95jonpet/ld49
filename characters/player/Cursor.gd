extends Area2D

onready var tile_map: TileMap = get_node("../TileMap")
onready var player: Player = get_node("../Player")

var tile_position: Vector2 = Vector2.ZERO

func _physics_process(_delta: float) -> void:
	if not player:
		return
	
	var player_tile_position := tile_map.world_to_map(player.global_position)
	tile_position = player_tile_position + Vector2(player.facing_direction, 0)
	global_position = tile_map.map_to_world(tile_position)


func _input(event: InputEvent) -> void:
	if not event.is_action_pressed("ui_action") or not player or not player.current_item or not player.current_item.is_ready():
		return
	
	var overlapping_nodes: Array = get_overlapping_bodies()
	
	if overlapping_nodes.empty():
		player.current_item.use_on_free(global_position)
	else:
		for node in overlapping_nodes:
			player.current_item.use_on_node(node)
