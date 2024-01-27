extends Node2D

@onready var port_input = %Port
@onready var address_input = %Address
@onready var start = %Start
@onready var start_timer = $StartTimer
@onready var username_input = %Username
@onready var autostart_timer = %AutoStartTimer

@export var player_scene: PackedScene
@export var autostart_amount = 2

var peer = ENetMultiplayerPeer.new()

func _ready():
	var cmdline_args = OS.get_cmdline_user_args()
	#print("Command Line Arguments:", cmdline_args)
	if cmdline_args.size() > 0:
		if cmdline_args[0] == "--autostart-amount":
			print(cmdline_args[1])
			autostart_amount = cmdline_args[1].to_int()
		
	get_tree().paused = true
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_connected.connect(peer_connected)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	
	if DisplayServer.get_name() == "headless":
		host_game(port_input.text.to_int())
	
func connected_to_server():
	var username
	if username_input.text != "" and username_input.text != "Guest":
		username = username_input.text
	else:
		username = "Guest " + str(multiplayer.get_unique_id())

	send_player_info.rpc_id(1, username, multiplayer.get_unique_id(), "T", Items.default_t_items, "secondary")
	
func peer_connected(id):
	#print("Peer with ID " + str(id) + " connected.")
	if multiplayer.is_server() and GameValues.players.size() >= autostart_amount - 1:
		autostart_timer.start()
	
func peer_disconnected(id):
	if id != 1:
		print(GameValues.players[id].username + " disconnected.")
		GameValues.players.erase(id)
	else:
		print("SERVER WENT OFFLINE.")
		get_tree().quit()
	
	var player_nodes = get_tree().get_nodes_in_group("Player")
	for player_node in player_nodes:
		if player_node.id == id:
			GameValues.send_message(player_node.username + " has disconnected.", "SERVER")
			player_node.queue_free()
		
func _on_host_pressed():
	host_game(port_input.text.to_int())
	start.disabled = false

func _on_start_pressed():
	start_game.rpc()
	
func _on_start_timer_timeout():
	start_game.rpc()
	print("start timer timeout")

func _on_join_pressed():
	print(address_input.text)
	join_game(address_input.text, port_input.text.to_int())

func host_game(port: int):
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	
func join_game(address: String, port: int):
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	
func add_players():
	var added_players = 0
	
	for i in GameValues.players:
		var given_bomb = false
		added_players += 1

		var player = player_scene.instantiate()
		player.id = i
		player.username = GameValues.players[i].username
		player.index = added_players
		
		if added_players % 2 == 1:
			player.team = "T"
			GameValues.players[i].items = Items.default_t_items
			
			if not given_bomb:
				GameValues.players[i].items.bomb = Items.items.bomb
				given_bomb = true
		
		elif added_players % 2 == 0:
			player.team = "CT"
			GameValues.players[i].items = Items.default_ct_items
		
		$Level/Players.add_child(player)

@rpc("any_peer")
func send_player_info(username, id, team, items, equipped_item):
	if not GameValues.players.has(id):
		GameValues.players[id] = {
			"username": username,
			"id": id,
			"team": team,
			"items": items,
			"equipped_item": "secondary",
			"kills": 0,
			"deaths": 0,
		}
		
	if multiplayer.is_server():
		for i in GameValues.players:
			send_player_info.rpc(GameValues.players[i].username, i, team, items, equipped_item)

@rpc("any_peer", "call_local", "reliable")
func start_game():
	add_players()
	
	get_tree().paused = false
	$MenuUI.visible = false
	$Level/GameUI.make_visible()
	
	$Level.visible = true
	$Level.new_round()

func _on_username_text_changed(new_text):
	pass

func _on_auto_start_timer_timeout():
	start_game.rpc()
