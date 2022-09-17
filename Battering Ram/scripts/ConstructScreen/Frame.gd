extends Sprite

signal pressed

var status
var left
var right
var top
var bottom


# Called when the node enters the scene tree for the first time.
func _ready():
	var size = scale * $Unlocked.texture.get_size()
	
	left = position.x - size.x/2
	right = left + size.x
	top = position.y - size.y/2
	bottom = top + size.y

func update():
	for child in get_children():
		child.visible = false
	
	if status == 'locked':
		$Locked.visible = true
	elif status == 'unlocked':
		$Unlocked.visible = true
	elif status == 'soldOut':
		$SoldOut.visible = true

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		if event.button_index == 1:
			if status != 'unlocked':
				return
			
			var pos = event.position
			var x = pos.x; var y = pos.y
			
			if (left < x && x < right) && (top < y && y < bottom):
				emit_signal('pressed')
