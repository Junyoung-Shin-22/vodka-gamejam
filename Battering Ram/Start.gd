extends Sprite


var scale_delta = Vector2(0.001, 0.001)
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
	
	# print([left, right, top, bottom])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if scale.x > scale_max:
		scale_direction = -1
	elif scale.x < scale_min:
		scale_direction = 1
	
	scale += scale_direction * scale_delta
	# print(scale)

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			var pos = event.position
			var x = pos.x; var y = pos.y
			
			# print([x, y])
			
			if (left < x && x < right) && (top < y && y < bottom):
				print('clicked')
			else:
				print('not clicked')
