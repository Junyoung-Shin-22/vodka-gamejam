extends HBoxContainer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func fit_children():
	var size
	var count
	
	size = get_rect().size
	
	count = get_child_count()
	
	var i = 1
	for child in get_children():
		child.position = Vector2(size.x * i / (count+1), size.y / 2)
		child.scale =\
		 0.6 * Vector2.ONE * size.y / child.frames.get_frame("Ram", 0).get_size().y
		i += 1 

#func _on_ItemList_child_added():
#	fit_children()
