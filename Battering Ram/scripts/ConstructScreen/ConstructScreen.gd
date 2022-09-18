extends Control

signal go_pressed(money, level, cart, itemStatus)

const stream = preload('res://assets/bgm/crafting.mp3')
const Item = preload('res://scenes/Item.tscn')

var currentMoney
var currentLevel
var currentCart
var currentItemStatus

# weapons prices
const cannonPrice = 100


func get_parent_player():
	for node in get_parent().get_parent().get_children():
		if node.get_class() == "AudioStreamPlayer2D":
			return node
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	# play shop bgm
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
	currentItemStatus = status
	
	$CartContainer.add_child(currentCart)
	
	var ram = Item.instance()
	ram.type = 'Ram'
	$RamContainer.add_child(ram)
	$RamFrame.status = currentItemStatus['Ram']
	$RamFrame.price = currentItemStatus['ram_price']
	
	var fire = Item.instance()
	fire.type = 'Fire'
	$FireContainer.add_child(fire)
	$FireFrame.status = currentItemStatus['Fire']
	$FireFrame.price = currentItemStatus['fire_price']
	
	
	var cannon = Item.instance()
	cannon.type = 'Cannon'
	$CannonContainer.add_child(cannon)
	$CannonFrame.status = currentItemStatus['Cannon']
	$CannonFrame.price = currentItemStatus['cannon_price']
	

func update():
	$Level.text = 'level %02d'%currentLevel
	$Money.text = '%05d'%currentMoney
	
	currentCart.update()
	$RamFrame.update()
	$FireFrame.update()
	$CannonFrame.update()

# TODO: set & check price
func _on_RamFrame_pressed():
	if currentMoney < currentItemStatus['ram_price']:
		return
	
	currentCart.ram.activate()
	currentMoney -= currentItemStatus['ram_price']
	
	currentItemStatus['Ram'] = 'soldOut'
	$RamFrame.status = currentItemStatus['Ram']
	update()


func _on_FireFrame_pressed():
	if currentMoney < currentItemStatus['fire_price']:
		return
		
	currentCart.fire.activate()
	currentMoney -= currentItemStatus['fire_price']
	
	currentItemStatus['Fire'] = 'soldOut'
	$FireFrame.status = currentItemStatus['Fire']
	update()


func _on_CannonFrame_pressed():
	if currentMoney < currentItemStatus['cannon_price']:
		return
		
	currentCart.cannon.activate()
	currentMoney -= currentItemStatus['cannon_price']
	
	currentItemStatus['Cannon'] = 'soldOut'
	$CannonFrame.status = currentItemStatus['Cannon']
	update()

func _on_Go_pressed():
	currentCart.reset()
	$CartContainer.remove_child(currentCart)
	emit_signal('go_pressed', currentLevel, currentMoney, currentCart, currentItemStatus)
