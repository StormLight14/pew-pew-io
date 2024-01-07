extends Node

var players = {}
var typing = false
var can_interact = false
var shop_open = false
var messages = ""

var player_money = 1000

signal message_sent_signal
signal player_killed_signal

@rpc("any_peer", "call_local", "reliable")
func send_message(message = "MESSAGE_ERROR", username = "USERNAME_ERROR"):
	var full_message = username + ": " + message + "\n"
	print(full_message)
	
	messages += full_message
	message_sent_signal.emit()
	
@rpc("any_peer", "call_local", "reliable")
func player_killed(killer_id, victim_id):
	players[killer_id].kills += 1
	players[victim_id].deaths += 1
	
	player_killed_signal.emit()
