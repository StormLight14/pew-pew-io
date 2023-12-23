extends Node2D

@onready var port_input = %Port
@onready var address_input = %Address
@onready var start = %Start
@onready var start_timer = $StartTimer

@export var player_scene: PackedScene

var peer = ENetMultiplayerPeer.new()

func _ready():
	get_tree().paused = true
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.peer_disconnected.connect(peer_disconnected)
	$Players.visible = false
	$GameUI.visible = false
	
	if DisplayServer.get_name() == "headless":
		start_timer.start()
		print("timer should have started?")
		host_game(port_input.text.to_int())
	
func connected_to_server():
	send_player_info.rpc_id(1, "Guest " + str(multiplayer.get_unique_id()), multiplayer.get_unique_id())
	
func peer_connected(id):
	print("Player with ID " + str(id) + " connected.")
	
func peer_disconnected(id):
	print(GameValues.players[id].username + " disconnected.")
	GameValues.players.erase(id)
	
	var player_nodes = get_tree().get_nodes_in_group("Player")
	for player_node in player_nodes:
		if player_node.name == str(id):
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
	join_game(address_input.text, port_input.text.to_int())

func host_game(port: int):
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	
func join_game(address: String, port: int):
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	
func add_players():
	for i in GameValues.players:
		var t_player_count = GameValues.get_player_count("T")
		var ct_player_count = GameValues.get_player_count("CT")
		
		var player = player_scene.instantiate()
		player.name = str(i)
		player.username = GameValues.players[i].username
		
		if t_player_count <= ct_player_count:
			player.team = "T"
		else:
			player.team = "CT"
		
		print("Created " + player.username + " on team " + player.team)
		$Players.add_child(player)
	
@rpc("any_peer")
func send_player_info(username, id):
	if not GameValues.players.has(id):
		GameValues.players[id] = {
			"username": username,
			"id": id,
		}
		
	if multiplayer.is_server():
		for i in GameValues.players:
			send_player_info.rpc(GameValues.players[i].username, i)

@rpc("any_peer", "call_local", "reliable")
func start_game():
	add_players()
	
	get_tree().paused = false
	$MenuUI.visible = false
	$GameUI.make_visible()
	
	
	$Level.visible = true
	$Players.visible = true

func _on_username_text_changed(new_text):
	pass
