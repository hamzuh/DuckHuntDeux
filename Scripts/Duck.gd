extends CharacterBody2D

#randomise duck speed
#randomise duck inital direction
#spawn from the floor at a centralised point of half width
#bounce off side walls
#once you reach the bounds kill the object, count a miss if the duck reaches the sky
#ducks can dodge later on?
#ducks can parry attacks?
#YOU CAN PARRY THE PROJECTILE BACK IN A BOSS FIGHT?
#blood seeps in from beyond the grass

@onready var sprite = $Sprite2D

func _ready():
	# Start with a low speed range and ramp it up slowly
	# Multiplied with the normalised direction vector
	var speed = randi_range(25, 65)
	velocity = _random_direction() * speed

func _random_direction():
	# The duck has to fly in a random path
	# Within a 60 degree range either left or right
	var angle = deg_to_rad(randf_range(195, 255))
	var direction_decide = randi_range(0, 1)
	
	if direction_decide:
		angle += deg_to_rad(90)
		sprite.flip_h = false
		
	return Vector2(cos(angle), sin(angle)).normalized()

func _flip():
	pass

func _physics_process(delta):
	var collide = move_and_collide(velocity * delta)
	
	if collide:
		velocity = velocity.bounce(collide.get_normal())

# Implement death function
# Play death animation and add point when shot
#func _death():
