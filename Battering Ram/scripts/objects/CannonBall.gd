extends AnimatedSprite

func _ready():
	pass # Replace with function body.

func _on_CannonBall_animation_finished():
	stop()
	get_parent().stop()
