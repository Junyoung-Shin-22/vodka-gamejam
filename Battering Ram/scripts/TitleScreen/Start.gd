extends Sprite

signal pressed

var scale_delta = Vector2.ONE / 30
var scale_direction = 1
var scale_min = 0.27
var scale_max = 0.33

var left = 0
var right = 0
var top = 0
var bottom = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	var size = scale * texture.get_size()
	
	left = position.x - size.x/2
	right = left + size.x
	top = position.y - size.y/2
	bottom = top + size.y

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scale.x > scale_max:
		scale_direction = -1
	elif scale.x < scale_min:
		scale_direction = 1
	
	scale += delta * scale_direction * scale_delta

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			var pos = event.position
			var x = pos.x; var y = pos.y
			
			if (left < x && x < right) && (top < y && y < bottom):
				emit_signal('pressed')
