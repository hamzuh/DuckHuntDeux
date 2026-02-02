extends State

@export var hit_state: State

func enter() -> void:
	if abs(rad_to_deg(parent.velocity.angle())) < 35 || abs(rad_to_deg(parent.velocity.angle())) > 145:
		animation_name = "Flying Horizontal"
	super()

func process_physics(delta: float) -> State:
	var collide = parent.move_and_collide(parent.velocity * delta)
	
	if collide:
		
		if collide.get_collider_shape().get_name() == "Top":
			parent.duck_wins.emit()
			parent.queue_free()
			
		parent.velocity = parent.velocity.bounce(collide.get_normal())
		if parent.velocity.x < 0:
			parent.sprite.flip_h = true
		else:
			parent.sprite.flip_h = false
			
	if parent.shot:
		return hit_state
	
	return null
