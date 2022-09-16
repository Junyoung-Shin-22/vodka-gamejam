extends Node2D

var level
var money

func init(currentLevel, currentMoney):
	level = currentLevel
	money = currentMoney
	
	$RichTextLabel.text = "level %d construction screen"%(level)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
