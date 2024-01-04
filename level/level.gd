extends Node2D

@onready var start_timer = $StartTimer
@onready var start_timer_label = %StartTimerLabel
@onready var end_timer = $EndTimer
@onready var end_timer_label = %EndTimerLabel

var t_round_wins = 0
var ct_round_wins = 0

func _ready():
	visible = false
	$GameUI.visible = false

func _process(_delta):
	if start_timer.is_stopped() == false:
		start_timer_label.text = "Starting in: " + str(ceil(start_timer.time_left))
		
	if end_timer.is_stopped() == false:
		end_timer_label.text = "Round ends in: " + format_time(end_timer.time_left)
		
func format_time(seconds: float) -> String:
	var minutes: int = int(seconds) / 60
	var seconds_remainder: int = int(seconds) % 60

	# Use string formatting to ensure leading zeros for single-digit minutes and seconds
	var formatted_time: String = "%02d:%02d" % [minutes, seconds_remainder]

	return formatted_time
	
func new_round():
	start_timer.start()
	
func _on_start_timer_timeout():
	start_timer_label.visible = false
	end_timer_label.visible = true
	
	GameValues.can_interact = true
	end_timer.start()
	
func _on_end_timer_timeout():
	start_timer_label.visible = true
	end_timer_label.visible = false
	
	GameValues.can_interact = false
	for player in get_tree().get_nodes_in_group("Player"):
		player.respawn()
	start_timer.start()
