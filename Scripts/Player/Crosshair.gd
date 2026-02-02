extends Area2D

@onready var collision: Node = $Collision
@onready var shotsound = $Boom

# Anti-spam measures
var canshoot: bool = false

func _ready():
	get_parent().game_ends.connect(_on_end)
	get_parent().game_starts.connect(_on_start)
	
func _process(delta):
	self.position = self.get_global_mouse_position()
	
func _input(event):
	if event.is_action_pressed("Shoot") && canshoot:
		shotsound.play()
		canshoot = false
		collision.disabled = false
		await get_tree().create_timer(0.1).timeout
		collision.disabled = true
		await get_tree().create_timer(0.4).timeout
		canshoot = true

func _on_body_entered(body):
	if body.is_in_group("Duck"):
		body.hit()

func _on_end(score):
	canshoot = false
	
func _on_start():
	canshoot = true
