extends AnimatedSprite

var ram
var fire
var cannon

func _ready():
	ram = $Ram
	ram.type = 'Ram'
	
	fire = $Fire
	fire.type = 'Fire'
	
	cannon = $Cannon
	cannon.type= 'Cannon'

func reset():
	scale = Vector2.ONE
	rotation = 0
