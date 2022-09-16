extends Node2D

var currentMoney
var currentLevel
var currentCart

# weapons prices
const cannonPrice = 100

# weapons existance
var cannonExists

# Called when the node enters the scene tree for the first time.
func _ready():
	$cannon.visible = false
	update_labels()
	
func init(currentLevel, currentMoney):
	self.currentLevel = currentLevel
	self.currentMoney = currentMoney
	
	cannonExists = false

func update_labels():
	$money.text = 'money: %d'%currentMoney
	$level.text = 'level: %d'%currentLevel

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_buyCannon_buy_cannon():
	if cannonExists == false && currentMoney >= cannonPrice:
		print('click signal recieved')
		currentMoney -= cannonPrice
		print(currentMoney)
		
		$cannon.visible = true
		update_labels()
