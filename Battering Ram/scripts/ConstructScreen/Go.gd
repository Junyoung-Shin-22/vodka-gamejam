extends Label

signal pressed

var left = 0
var right = 0
var top = 0
var bottom = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = get_rect().size
	var pos = get_rect().position
	
	left = pos.x 
	right = left + size.x
	top = pos.y
	bottom = top + size.y

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
			if event.button_index == 1:
				var pos = event.position
				var x = pos.x; var y = pos.y
				
				if (left < x && x < right) && (top < y && y < bottom):
					emit_signal('pressed')
