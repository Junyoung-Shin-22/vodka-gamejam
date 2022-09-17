extends Control

const stream = preload('res://assets/bgm/crafting.mp3')
const Item = preload('res://scenes/Item.tscn')

var currentMoney
var currentLevel
var currentCart
var itemStatus

# weapons prices
const cannonPrice = 100

# weapons existance
var cannonExists

func get_parent_player():
	for node in get_parent().get_children():
		if node.get_class() == "AudioStreamPlayer2D":
			return node
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	var BGM = get_parent_player()
	if BGM:
		BGM.stream = stream
		BGM.play()
	
	$CartContainer.fit_child()
	$RamContainer.fit_child()
	$FireContainer.fit_child()
	$CannonContainer.fit_child()
	
	update()
	
func init(level, money, cart, status):
	currentLevel = level
	currentMoney = money
	currentCart = cart
	itemStatus = status
	
	$CartContainer.add_child(currentCart)
	
	var ram = Item.instance()
	ram.type = 'Ram'
	$RamContainer.add_child(ram)
	$RamFrame.status = itemStatus[0]
	
	var fire = Item.instance()
	fire.type = 'Fire'
	$FireContainer.add_child(fire)
	$FireFrame.status = itemStatus[1]
	
	
	var cannon = Item.instance()
	cannon.type = 'Cannon'
	$CannonContainer.add_child(cannon)
	$CannonFrame.status = itemStatus[2]
	

func update():
	$Level.text = 'level %d'%currentLevel
	$Money.text = 'money: %d'%currentMoney
	
	currentCart.update()
	$RamFrame.update()
	$FireFrame.update()
	$CannonFrame.update()
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_RamFrame_pressed():
	currentCart.ram.activate()


func _on_FireFrame_pressed():
	currentCart.fire.activate()


func _on_CannonFrame_pressed():
	currentCart.cannon.activate()
