extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready():
	get_parent().score_changed.connect(_on_score_changed)
	get_parent().game_ends.connect(_on_end)
	get_parent().game_starts.connect(_on_start)
	$Text.text = ("Press SPACE to start.")
	$Score.text = ("")
	
func _on_score_changed(score):
	$Score.text = str(score)

func _on_end(score):
	if score == 0:
		$Text.text = (str(score) + " ducks hunted. Did you even try? \n Press SPACE to try again.")
	elif score == 1:
		$Text.text = ("Only " + str(score) + " duck hunted? Wake up! \n Press SPACE to try again.")
	elif score <= 20:
		$Text.text = (str(score) + " ducks hunted. \n Press SPACE to try again.")
	else:
		$Text.text = ("Wow, " + str(score) + " ducks hunted! \n Press SPACE to try again.")
	$Score.text = ("")
	$"Round Start".stop()
	$"Round End".play()
	
func _on_start():
	$Text.text = ("")
	$Score.text = ("0")
	$"Round End".stop()
	$"Round Start".play()
