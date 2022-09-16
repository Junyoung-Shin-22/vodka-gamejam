extends Sprite

var left
var right
var top
var bottom

signal buy_cannon()

func _ready():
	var size = scale * texture.get_size()
	
	left = position.x - size.x/2
	right = left + size.x
	top = position.y - size.y/2
	bottom = top + size.y


func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			var pos = event.position
			var x = pos.x; var y = pos.y
			
			if (left < x && x < right) && (top < y && y < bottom):
				print("buy cannon clicked")
				emit_signal("buy_cannon")
