extends AnimatedSprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var ConstructScreen = get_parent()
	ConstructScreen.connect("boughtcannon", self, "_on_ConstructScreen_boughtcannon")
	visible = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _on_ConstructScreen_boughtcannon():
	visible = true
	print("became visible!")
