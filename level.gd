extends Node2D

@onready var start_timer = $StartTimer
@onready var start_timer_label = $GameUI/CenterContainer/StartTimerLabel

var t_round_wins = 0
var ct_round_wins = 0

func _ready():
	visible = false
	$GameUI.visible = false
	
func _process(_delta):
	if start_timer.is_stopped() == false:
		start_timer_label.text = "Starting in: " + str(ceil(start_timer.time_left))
	
func new_round():
	start_timer.start()
	
func _on_start_timer_timeout():
	start_timer_label.visible = false
	GameValues.can_interact = true
