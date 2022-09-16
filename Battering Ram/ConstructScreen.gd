extends Node2D

var money 
var cannon_price = 100
var hascannon

# Declare member variables here. Examples: 
# var b = "text"

signal boughtcannon()
signal return_money(balance)
# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon_cannon_buy = get_node("weapon_cannon_buy")
	weapon_cannon_buy.connect("buy_cannon", self, "_on_weapon_cannon_buy_buycannon")
	hascannon = false
	money = 120


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("return_money",money)
#	pass
func _on_weapon_cannon_buy_buycannon():
	if hascannon == false and money >= cannon_price:
		money -= cannon_price
		hascannon = true
		emit_signal("boughtcannon")
		print("bought cannon!")
	
