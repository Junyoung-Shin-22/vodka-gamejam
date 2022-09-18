extends AnimatedSprite

var type = ''
var activated = false

func _ready():
	animation = type
		
func activate():
	activated = true
	
	frame = 0
	playing = false
	
	for child in get_children():
		child.frame = 0
		child.playing = false
	
	visible = true		

func play_animation():
	frame = 0
	play()
	for child in get_children():
		frame = 0
		child.play()

func attack(target):
	if visible and target:
		return target.attack(type)
	return false

func use(target):
	play_animation()
	return attack(target)


func _on_Ram_animation_finished():
	stop()

func _on_Fire_animation_finished():
	stop()

func _on_Cannon_animation_finished():
	stop()
