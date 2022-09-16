extends Sprite

var left = 0
var right = 0
var top = 0
var bottom = 0
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
			
			# print([x, y])
			
			if (left < x && x < right) && (top < y && y < bottom):
				emit_signal("buy_cannon")
				print("buy")
