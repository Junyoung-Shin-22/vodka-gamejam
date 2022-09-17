extends Node2D

var Cart = preload('res://scenes/Cart.tscn')
var ConstructScreen = preload('res://scenes/ConstructScreen.tscn')

const initialLevel = 1
const initialMoney = 1000
const initialItemStatus = ['unlocked', 'unlocked', 'unlocked']
var initialCart = Cart.instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	$BGM.play()


func _on_TitleScreen_start_pressed():
	remove_child($TitleScreen)
	
	var constructScreen = ConstructScreen.instance()
	constructScreen.init(initialLevel, initialMoney, 
		initialCart, initialItemStatus)
	
	add_child(constructScreen)
