extends CharacterBody2D

# Node assignments
@onready var sprite: Node = $Sprite2D

# Movement Variables
var speed_range: int
var speed: int
var direction: Vector2
var falling_speed: Vector2 = Vector2(0, 90)

# Health Variables
var shot: bool = false

# Signals
signal duck_died
signal duck_wins

# State Machines Variables
@onready var state_machine: Node = $"State Machine" 
@onready var animation: Node = $AnimationPlayer

func random_direction():
	# The duck has to fly in a random path
	# Within a 60 degree range either left or right
	var angle = deg_to_rad(randf_range(190, 250))
	var direction_decide = randi_range(0, 1)
	
	if direction_decide:
		angle += deg_to_rad(90)
		sprite.flip_h = false
		
	return Vector2(cos(angle), sin(angle)).normalized()

func _ready() -> void:
	position.x = randi_range(-65, 65)
	position.y = 59
	speed = randi_range(speed_range - 10, speed_range + 10)
	direction = random_direction()
	velocity = direction * speed
	state_machine.init(self, animation)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	
func _process(delta):
	state_machine.process_frame(delta)

func hit():
	shot = true
