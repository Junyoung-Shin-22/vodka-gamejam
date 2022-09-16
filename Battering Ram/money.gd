extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var money = 0
signal fetch_money()
# Called when the node enters the scene tree for the first time.
func _ready():
	text = "MONEY: 0" 
	var ConstructScreen = get_parent()
func _on_ConstructScreen_return_money(balance):
	money = balance
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = "MONEY: " + str(money)
#	pass
