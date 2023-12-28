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

func get_player_count(team):
	var amount = 0

	match team.to_upper():
		"ANY":
			for id in players.keys():
				amount += 1
		"CT":
			for id in players.keys():
				amount += 1
				if players[id].team == "CT":
					amount += 1
		"T":
			for id in players.keys():
				amount += 1
				if players[id].team == "T":
					amount += 1
	
	print(team + ": " + str(amount))
	return amount
