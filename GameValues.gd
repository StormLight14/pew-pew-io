extends Node

var players = {}
var typing = false
var can_interact = false
var shop_open = false
var game_started = false
var messages = ""
var rounds_won = [0, 0] # T, CT
var player_money = 10000
var bomb_exploded = false

signal message_sent_signal
signal player_killed_signal
signal player_stat_changed_signal
signal update_ammo_ui

func get_alive_players() -> Array[int]:
	var t_alive = 0
	var ct_alive = 0
	
	for player in get_tree().get_nodes_in_group("Player"):
		if player.alive:
			if player.team == "T":
				t_alive += 1
			else:
				ct_alive += 1
	
	return [t_alive, ct_alive]

@rpc("any_peer", "call_local", "reliable")
func send_message(message = "MESSAGE_ERROR", username = "USERNAME_ERROR", player_id = 1):
	var color = "#FFFFFF"
	
	if player_id == 1:
		color = "#FF4D4D"
	else:
		match players[player_id].team:
			"T":
				color = "#FFA836"
			"CT":
				color = "#364AFF"
		
		
	if message != "" and message != " ":
		var full_message = "[color=" + color + "]" + username + "[/color]" + ": " + message + "\n"
		print(full_message)
		
		messages += full_message
		message_sent_signal.emit()
	
@rpc("any_peer", "call_local", "reliable")
func player_killed(killer_id, victim_id, victim_team):
	players[killer_id].kills += 1
	players[victim_id].deaths += 1
	
	var alive_players = get_alive_players()
	for level in get_tree().get_nodes_in_group("Level"):
		if alive_players[0] == 0: # all T's are dead
			level.start_post_round("CT")
			rounds_won[1] += 1
		elif alive_players[1] == 0: # all CT's are dead
			level.start_post_round("T")
			rounds_won[0] += 1

	if victim_team == "T":
		players[victim_id].items = Items.default_t_items
	else:
		players[victim_id].items = Items.default_ct_items
	
	player_killed_signal.emit()

@rpc("any_peer", "call_local", "reliable")
func change_player_stat(id, stat, value):
	players[id][stat] = value
	
	if stat == "equipped_item":
		for player in get_tree().get_nodes_in_group("Player"):
			if player.id == id:
				if players[id].items[value]:
					player.gun_sprite.texture = load(players[id].items[value].sprite)
	
	player_stat_changed_signal.emit()
