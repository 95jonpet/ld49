extends FiniteStateMachine

func _init() -> void:
	_add_state("dry")
	_add_state("hydrated")


func _ready() -> void:
	set_state(states.dry)


func _state_logic(_delta: float) -> void:
	pass


func _get_transition() -> int:
	match state:
		states.dry:
			if parent.hydration >= 0.35:
				return states.hydrated
		states.hydrated:
			if parent.hydration < 0.35:
				return states.dry
	
	return -1


func _enter_state(_previous_state: int, new_state: int) -> void:
	match new_state:
		states.dry:
			animation_player.play("dry")
		states.hydrated:
			animation_player.play("hydrated")
