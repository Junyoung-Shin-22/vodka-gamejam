extends AnimatedSprite

var type = ''
var activated = false

func _ready():
	animation = type
		
func activate():
	activated = true
	
	frame = 0
	playing = false
	
	visible = true		

func use():
	play()


func _on_Ram_animation_finished():
	stop()


func _on_Fire_animation_finished():
	stop()


func _on_Cannon_animation_finished():
	stop()
