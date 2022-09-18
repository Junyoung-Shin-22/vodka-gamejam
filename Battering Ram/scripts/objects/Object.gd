extends AnimatedSprite

var type
var health

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

func init(type, position, animation):
	self.type = type
	
	if type == 'DIRT' || type == 'WOOD':
		health = 2
	elif type == 'STONE':
		health = 4
	
	self.position = position
	self.animation = animation

func attack(attack_type):
	if type == 'END':
		return
	
	if type == 'DIRT':
		if attack_type == 'Fire':
			if health == 2:
				animation = 'DirtFire'
		
		else:
			if attack_type == 'Ram':
				health -= 1
			elif attack_type == 'Cannon':
				health -= 2
			
			if health >= 1:
				animation = 'DirtHit'
			else:
				animation = 'DirtBreak'
	
	elif type == 'WOOD':
		if attack_type == 'Fire':
			health -= 2
			animation = 'WoodFire'
		
		else:
			if attack_type == 'Ram':
				health -= 1
			elif attack_type == 'Cannon':
				health -= 2
			
			if health >= 1:
				animation = 'WoodStop2'
			else:
				animation = 'WoodStop3'
	
	elif type == 'STONE':
		if attack_type == 'Fire':
			animation = 'StoneFire'
			
		else:
			if attack_type == 'Ram':
				health -= 1
			elif attack_type == 'Cannon':
				health -= 4
		
			if health == 2:
				animation = 'StoneHit'
			elif health < 1:
				animation = 'StoneBreak'
	
	if health <= 0:
		return true
