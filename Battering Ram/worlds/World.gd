extends Node2D

signal clear

const DIRECTIONS = [Vector2.UP, Vector2.LEFT, Vector2.DOWN, Vector2.RIGHT]

var stream = preload('res://assets/bgm/main.mp3')
var Objects = preload('res://scenes/Object.tscn')

var currentLevel

var worldMap # nested list of [[movable_direction], object]
var worldInfo

var currentCart
var cartHeading = Vector2.DOWN

var maxTurns
var turnsCount = 0

var levelLabel
var turnsLabel

func get_parent_player():
	for node in get_parent().get_parent().get_children():
		if node.get_class() == "AudioStreamPlayer2D":
			return node
	return null

# Called when the node enters the scene tree for the first time.
func _ready():
	var BGM = get_parent_player()
	if BGM:
		BGM.stream = stream
		BGM.play()
	
	setup_worldmap()
	
	var start = find_start()
	currentCart.position = index_to_coord(start)
	
	while cartHeading != worldMap[start.x][start.y][0][0]:
		rotate_ccw()
	
	var font = DynamicFont.new()
	font.set_font_data(load('res://assets/fonts/press-start/prstart.ttf'))
	font.size = 8
	
	levelLabel = Label.new()
	turnsLabel = Label.new()
	
	add_child(currentCart)
	add_child(levelLabel)
	add_child(turnsLabel)
	
	levelLabel.rect_position = Vector2(2, 2)
	levelLabel.add_font_override("font", font)
	levelLabel.text = 'Level: %02d'%currentLevel
	
	turnsLabel.rect_position = Vector2(2, 12)
	turnsLabel.add_font_override("font", font)
	turnsLabel.text = 'Turns: 0 / %d'%maxTurns

func setup_worldmap():
	worldMap = []
	
	for i in range(7):
		var line = []
		for j in range(7):
			var box = [[], null] # [[moveable directions], object(if exists)]
			
			# adding movable directions
			for k in range(4):
				if worldInfo[i][j][0][k] == '1':
					box[0].append(DIRECTIONS[k])
			
			# adding object
			var label = worldInfo[i][j][1]
			if label && label != 'START':
				var animation
				if label == 'END':
					animation = 'Goal'
				elif label == 'DIRT':
					animation = 'DirtStop'
				elif label == 'WOOD':
					animation = 'WoodStop'	
				elif label == 'STONE':
					animation = 'StoneStop'
				
				var object = Objects.instance()
				object.init(label, index_to_coord(Vector2(i, j)), animation)
				box[1] = object
				add_child(object)
			
			line.append(box)
		worldMap.append(line)

func find_start():
	for i in range(7):
		for j in range(7):
			if worldInfo[i][j][1] == 'START':
				return Vector2(i ,j)

func index_to_coord(index):
	return 16*Vector2.ONE + 32*Vector2(index.y, index.x)

func coord_to_index(coord):
	return (Vector2(coord.y, coord.x) - 16*Vector2.ONE) / 32

func init(level, info, cart, turns):
	currentLevel = level
	worldInfo = info
	currentCart = cart
	maxTurns = turns
	
func get_front_index():
	var currentIndex = coord_to_index(currentCart.position)
	var i = currentIndex.x
	var j = currentIndex.y
	
	if cartHeading == Vector2.UP:
		i -= 1
	elif cartHeading == Vector2.LEFT:
		j -= 1
	elif cartHeading == Vector2.DOWN:
		i += 1
	elif cartHeading == Vector2.RIGHT:
		j += 1
	
	if i < 0 || i > 6 || j < 0 || j > 6:
		return null
	
	return Vector2(i, j)
	
func get_front_object():
	var fi = get_front_index()
	
	if fi == null:
		return null
	
	return worldMap[fi.x][fi.y][1]
	
func can_move():
	var index = coord_to_index(currentCart.position)
	
	var i = index.x
	var j = index.y
	
	if i < 0 || i > 6 || j < 0 || j > 6:
		return false
	
	var frontIndex = get_front_index()
	if frontIndex == null:
		return false
	
	var fi = frontIndex.x
	var fj = frontIndex.y
	
	var moveableDirections = worldMap[i][j][0]
	var objectInfo = worldMap[fi][fj][1]
	
	if objectInfo and objectInfo.type != 'END':
		return false

	if not (cartHeading in moveableDirections):
		return false
	
	return true

func rotate_ccw():
	currentCart.rotation -= PI/2
	cartHeading = Vector2(cartHeading.y, -cartHeading.x)

func rotate_cw():
	currentCart.rotation += PI/2
	cartHeading = Vector2(-cartHeading.y, cartHeading.x)

func distroy_object(index):
	worldMap[index.x][index.y][1] = null

func world_clear():
	currentCart.reset()
	remove_child(currentCart)
	emit_signal('clear', currentLevel, currentCart, turnsCount)

func _input(event):
	if event.is_action_pressed('forward'):
		if can_move():
			if get_front_object() != null:
				world_clear()
			else:
				currentCart.position += 32 * cartHeading
		
	elif event.is_action_pressed('ccw'):
		rotate_ccw()
	
	elif event.is_action_pressed('cw'):
		rotate_cw()
	
	elif event.is_action_pressed('weapon1'):
		var frontObject = get_front_object()
		var result = false
		
		result = currentCart.ram.use(frontObject)
		if result:
			distroy_object(get_front_index())
			
	
	elif event.is_action_pressed('weapon2'):
		var frontObject = get_front_object()
		var result = false
		
		result = currentCart.fire.use(frontObject)
		if result:
			distroy_object(get_front_index())
	
	elif event.is_action_pressed('weapon3'):
		var frontObject = get_front_object()
		var result = false
		
		result = currentCart.cannon.use(frontObject)
		if result:
			distroy_object(get_front_index())
	
	else:
		return
	
	turnsCount += 1
	turnsLabel.text = 'Turns: %d / %d'%[turnsCount, maxTurns]
