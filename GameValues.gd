extends Node

var players = {}
var typing = false
var can_interact = false
var shop_open = false
var messages = ""

var player_money = 10000

signal message_sent_signal
signal player_killed_signal

@rpc("any_peer", "call_local", "reliable")
func send_message(message = "MESSAGE_ERROR", username = "USERNAME_ERROR"):
	if message != "" and message != " ":
		var full_message = username + ": " + message + "\n"
		print(full_message)
		
		messages += full_message
		message_sent_signal.emit()
	
@rpc("any_peer", "call_local", "reliable")
func player_killed(killer_id, victim_id):
	players[killer_id].kills += 1
	players[victim_id].deaths += 1
	
	player_killed_signal.emit()
	
@rpc("any_peer", "call_local", "reliable")
func change_player_stat(id, stat, value):
	players[id][stat] = value
	
	if stat == "equipped_item":
		for player in get_tree().get_nodes_in_group("Player"):
			if player.name.to_int() == id:
				if players[id].items[value]:
					player.gun_sprite.texture = load(players[id].items[value].sprite)
					print(players[id].items[value])
