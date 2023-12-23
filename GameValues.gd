extends Node

var players = {}
var typing = false
var messages = ""

signal message_sent

@rpc("any_peer", "call_local", "reliable")
func send_message(message = "MESSAGE_ERROR", username = "USERNAME_ERROR"):
	var full_message = username + ": " + message + "\n"
	print(full_message)
	
	messages += full_message
	message_sent.emit()

func get_player_count():
	var amount = 0
	for i in GameValues.players:
		amount += 1
	
	return amount
