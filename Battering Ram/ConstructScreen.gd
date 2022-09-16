extends Node2D

var level
var money

# weapons prices
const cannon_price = 100

# weapon status
var hascannon

signal boughtcannon()
signal return_money(balance)

func init(currentLevel, currentMoney):
	level = currentLevel
	money = currentMoney
	
	$RichTextLabel.text = "level %d construction screen"%(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	var weapon_cannon_buy = get_node("weapon_cannon_buy")
	weapon_cannon_buy.connect("buy_cannon", self, "_on_weapon_cannon_buy_buycannon")
	hascannon = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	emit_signal("return_money", money)
	

func _on_weapon_cannon_buy_buycannon():
	if hascannon == false and money >= cannon_price:
		money -= cannon_price
		hascannon = true
		emit_signal("boughtcannon")
		print("bought cannon!")
