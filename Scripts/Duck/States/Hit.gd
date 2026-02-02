extends State

@export var falling_state: State

var finished: bool = false

func _on_animation_player_animation_finished(anim_name):
	if anim_name == animation_name:
		finished = true

func process_physics(delta: float) -> State:
	if finished:
		finished = false
		return falling_state
	return null
