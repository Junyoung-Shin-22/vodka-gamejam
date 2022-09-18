extends Node2D

var Cart = preload('res://scenes/Cart.tscn')
var ConstructScreen = preload('res://scenes/ConstructScreen.tscn')
var Score = preload('res://scenes/Score.tscn')
var Ending = preload('res://scenes/Ending.tscn')

var currentMoney = 0
var currentLevel = 0
var currentCart = Cart.instance()
var currentItemStatus = {'Ram': 'locked', 'Fire': 'locked', 'Cannon': 'locked', 
	'ram_price': 0, 'fire_price': 0, 'cannon_price': 0}

var currentWorldInfo

var Worlds =\
 [
	preload('res://worlds/World00.tscn'),
	preload('res://worlds/World01.tscn'),
	preload('res://worlds/World02.tscn'),
	preload('res://worlds/World03.tscn'),
	preload('res://worlds/World04.tscn'),
	preload('res://worlds/World05.tscn'),
	preload('res://worlds/World06.tscn'),
	preload('res://worlds/World07.tscn'),
	preload('res://worlds/World08.tscn'),
	preload('res://worlds/World09.tscn'),
	preload('res://worlds/World10.tscn'),
]

var WorldInfo =\
 [
	'res://worlds/World00.txt',
	'res://worlds/World01.txt',
	'res://worlds/World02.txt',
	'res://worlds/World03.txt',
	'res://worlds/World04.txt',
	'res://worlds/World05.txt',
	'res://worlds/World06.txt',
	'res://worlds/World07.txt',
	'res://worlds/World08.txt',
	'res://worlds/World09.txt',
	'res://worlds/World10.txt',
]

# Called when the node enters the scene tree for the first time.
func _ready():
	$BGM.play()

func parse_world_info(filename):
	var worldInfo = {}
	
	var f = File.new()
	f.open(filename, File.READ)
	
	for i in range(5):
		var line = f.get_line().split('=')
		worldInfo[line[0]] = int(line[1])
	
	var mapInfo = []
	while not f.eof_reached():
		mapInfo.append([])
		var line = f.get_line().split(',')
		for i in range(7):
			mapInfo[-1].append([line[i], line[i+7]])
	
	worldInfo['map_info'] = mapInfo
	f.close()
	
	return worldInfo

func empty_parent_screen():
	while $ParentScreen.get_child_count():
		$ParentScreen.remove_child($ParentScreen.get_child(0))

# start construction
func _on_TitleScreen_start_pressed():
	empty_parent_screen()
	start_construction()
	
func start_construction():
	currentWorldInfo = parse_world_info(WorldInfo[currentLevel])
	var constructScreen = ConstructScreen.instance()
	
	# updating item status
	if currentLevel == 1:
		currentItemStatus['Ram'] = 'unlocked'
		currentItemStatus['ram_price'] = 0
	
	if currentWorldInfo['fire_price'] > 0:
		if currentItemStatus['Fire'] != 'soldOut':
			currentItemStatus['Fire'] = 'unlocked'
			currentItemStatus['fire_price'] = currentWorldInfo['fire_price']
	
	if currentWorldInfo['cannon_price'] > 0:
		if currentItemStatus['Cannon'] != 'soldOut':
			currentItemStatus['Cannon'] = 'unlocked'
			currentItemStatus['cannon_price'] = currentWorldInfo['cannon_price']
	
	constructScreen.init(currentLevel, currentMoney, 
		currentCart, currentItemStatus)
	
	$ParentScreen.add_child(constructScreen)
	constructScreen.connect('go_pressed', self, '_on_ConstructScreen_go_pressed')

# start gameplay
func _on_ConstructScreen_go_pressed(level, money, cart, status):
	remove_child($ConstructScreen)
	
	currentLevel = level
	currentMoney = money
	currentCart = cart
	currentItemStatus = status
	
	start_world()
	
func start_world():
	var world = Worlds[currentLevel].instance()
	world.scale = Vector2.ONE * 4
	
	# fit cart into the map
	currentCart.scale = Vector2.ONE * 40 / currentCart.frames.get_frame("default", 0).get_size().x
	world.init(currentLevel, currentWorldInfo['map_info'],
		currentCart, currentWorldInfo['max_turns'])
	
	$ParentScreen.add_child(world)
	world.connect('clear', self, '_on_World_clear')
	

func _on_World_clear(level, cart, turns):
	empty_parent_screen()
	
	if currentLevel == 10:
		start_ending()
		return
		
	currentCart = cart
	currentLevel += 1
	currentCart = cart
	
	start_score(level, cart, turns)

func start_score(level, cart, turns):
	var score = Score.instance()
	score.init(currentLevel, currentMoney, currentWorldInfo, turns)
	
	$ParentScreen.add_child(score)
	score.connect('score_finished', self, '_on_Score_Finished')
	
	var moneyGiven = currentWorldInfo['money_given']
	var maxTurns = currentWorldInfo['max_turns']
	var panelty = currentWorldInfo['panelty']
	currentMoney += moneyGiven - (turns - maxTurns)*panelty

func _on_Score_Finished():
	empty_parent_screen()
	
	start_construction()

func start_ending():
	var ending = Ending.instance()
	ending.score = currentMoney
	$ParentScreen.add_child(ending)
	
	ending.frame = 0
	ending.play()
	return
