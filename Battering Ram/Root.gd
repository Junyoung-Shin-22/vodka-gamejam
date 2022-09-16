extends Node2D

var ConstructScreen = preload("./ConstructScreen.tscn")
onready var titleScreen = $TitleScreen

const initialLevel = 1
const initialMoney = 150

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_TitleScreen_start_pressed():
	# print("start pressed")
	var constructionScreen = ConstructScreen.instance()
	
	remove_child(titleScreen)
	
	add_child(constructionScreen)
	constructionScreen.init(initialLevel, initialMoney)
	
