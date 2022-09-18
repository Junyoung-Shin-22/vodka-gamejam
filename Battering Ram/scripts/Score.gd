extends Control

signal score_finished

var currentLevel
var currentMoney
var currentWorldInfo
var countTurns

# Called when the node enters the scene tree for the first time.
func _ready():
	var moneyGiven = currentWorldInfo['money_given']
	var maxTurns = currentWorldInfo['max_turns']
	var panelty = currentWorldInfo['panelty']
	var newMoney = currentMoney + moneyGiven - (countTurns - maxTurns)*panelty
	
	$LevelLabel.text = 'Level %02d Clear'%currentLevel
	$NumbersLabel.text = '%5d\n%5d\n%5d\n\n%5d'%[currentMoney, moneyGiven, -(countTurns - maxTurns)*panelty, newMoney]
	

func init(level, money, info, turns):
	currentLevel = level
	currentMoney = money
	currentWorldInfo = info
	countTurns = turns

func _input(event):
	if event is InputEventMouseButton && event.is_pressed():
		emit_signal('score_finished')
