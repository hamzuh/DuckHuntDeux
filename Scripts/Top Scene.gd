extends Node2D

# Preloaded scenes
@onready var Duck: PackedScene = preload("res://Scenes/Duck.tscn")

# Duck spawning variables
# Set the values
# Increment these on spawn in the _on_duck_died signal function
# Fix duck disappearing at top of screen, or end game on reach
# Make duck spawning into a function with optional parameter for speed
@export var duck_speed: int = 55
@export var duck_max_speed: int = 450

# Variables
var score: int = 0
var running: bool = false

# Signals
signal score_changed
signal game_ends
signal game_starts

# Hides mouse
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
# Exits game on Esc press
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	if event.is_action_pressed("ui_accept") && not running:
		game_starts.emit()

func _on_duck_died():
	score += 1
	score_changed.emit(score)
	duck_speed += 10
	if duck_speed > duck_max_speed:
		duck_speed = duck_max_speed
	var ducky = Duck.instantiate()
	ducky.duck_died.connect(_on_duck_died)
	ducky.duck_wins.connect(_on_duck_wins)
	ducky.speed_range = duck_speed
	add_child(ducky)
	
func _on_duck_wins():
	game_ends.emit(score)
	running = false

func _on_game_starts():
	# Reset variables
	running = true
	score = 0
	duck_speed = 55
	var ducky = Duck.instantiate()
	ducky.duck_died.connect(_on_duck_died)
	ducky.duck_wins.connect(_on_duck_wins)
	ducky.speed_range = duck_speed
	add_child(ducky)
