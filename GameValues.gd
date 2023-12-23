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
			for player in get_tree().get_nodes_in_group("Player"):
				amount += 1
		"CT":
			for player in get_tree().get_nodes_in_group("Player"):
				if player.team == "CT":
					amount += 1
		"T":
			for player in get_tree().get_nodes_in_group("Player"):
				if player.team == "T":
					amount += 1
	
	return amount
