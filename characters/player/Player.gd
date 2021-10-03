class_name Player
extends Character

enum ItemSwitchDirection {NEXT, PREVIOUS}

var current_item: Item
var facing_direction: int = 1 # left = 1, right = -1.

onready var items: Node2D = get_node("Items")

func _ready() -> void:
	current_item = items.get_child(0)


func _process(_delta: float) -> void:
	animated_sprite.flip_h = facing_direction == -1
	
	Weather.global_position = global_position
	
	if current_item:
		current_item.move(facing_direction)


func switch_item(direction: int) -> void:
	assert(direction == ItemSwitchDirection.NEXT or direction == ItemSwitchDirection.PREVIOUS)
	var index := current_item.get_index()
	if direction == ItemSwitchDirection.NEXT:
		index = wrapi(index + 1, 0, items.get_child_count())
	else:
		index = wrapi(index - 1, 0, items.get_child_count())
	current_item.hide()
	current_item = items.get_child(index)
	current_item.show()


func handle_input() -> void:
	move_direction = Vector2.ZERO
	if Input.is_action_pressed("ui_down"):
		move_direction += Vector2.DOWN
	if Input.is_action_pressed("ui_left"):
		move_direction += Vector2.LEFT
	if Input.is_action_pressed("ui_right"):
		move_direction += Vector2.RIGHT
	if Input.is_action_pressed("ui_up"):
		move_direction += Vector2.UP
	
	if move_direction.x == 1:
		facing_direction = 1
	elif move_direction.x == -1:
		facing_direction = -1
	
	if current_item and current_item.is_ready():
		if Input.is_action_just_pressed("ui_next_item"):
			switch_item(ItemSwitchDirection.NEXT)
		if Input.is_action_just_pressed("ui_previous_item"):
			switch_item(ItemSwitchDirection.PREVIOUS)
