extends Node2D

const initialLevel = 1
const initialMoney = 150

var ConstructScreen = preload('../scenes/ConstructScreen.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TitleScreen_start_pressed():
	remove_child($TitleScreen)
	
	var constructScreen = ConstructScreen.instance()
	constructScreen.init(initialLevel, initialMoney)
	
	add_child(constructScreen)
