extends AnimatedSprite

var stream = preload('res://assets/bgm/ending.mp3')

var score

func get_parent_player():
	for node in get_parent().get_parent().get_children():
		if node.get_class() == "AudioStreamPlayer2D":
			return node
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	var BGM = get_parent_player()
	if BGM:
		BGM.stream = stream
		BGM.play()


func _on_Button_pressed():
	get_tree().quit()


func _on_Ending_animation_finished():
	$End.visible = true
	$FinalScore.text = 'Final Score: %d'%score
