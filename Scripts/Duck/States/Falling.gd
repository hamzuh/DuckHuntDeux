extends State

@onready var falling: bool = true

func enter() -> void:
	$"../../Collider".disabled = true
	$"../../Falling".play()
	if parent.position.y < -40:
		parent.falling_speed = Vector2(0, 120) 
	super()

func _on_landing_finished():
	parent.queue_free()

func process_physics(delta: float) -> State:
	if falling:
		parent.move_and_collide(parent.falling_speed * delta)
		if parent.position.y >= 80:
			$"../../Falling".stop()
			$"../../Landing".play()
			parent.duck_died.emit()
			falling = false
	return null
