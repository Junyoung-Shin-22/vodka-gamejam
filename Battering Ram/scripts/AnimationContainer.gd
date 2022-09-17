extends CenterContainer

var Frame = preload('res://scenes/Frame.tscn')

# Called when the node enters the scene tree for the first time.
func _ready():
	fit_child()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fit_child():
	if not get_child_count():
		return
	
	var child = get_child(0)
	var size
	
	size = get_rect().size
	
	child.position = size / 2
	child.scale = Vector2.ONE * size.y / child.frames.get_frame("default", 0).get_size().y
	
