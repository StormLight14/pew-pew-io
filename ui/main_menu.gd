extends Control

@export var address = "127.0.0.1"
@export var port = 9595
var peer

func _ready():
	multiplayer.peer_connected.connect(player_connected)
	multiplayer.peer_disconnected.connect(player_disconnected)
	multiplayer.connected_to_server.connect(connected_to_server)
	multiplayer.connection_failed.connect(connection_failed)
	
@rpc("any_peer")
func send_player_info(name, id):
	if !GameManager.players.has(id):
		GameManager.players[id] = {
			"name": name,
			"id": id,
		}
	
	if multiplayer.is_server():
		for i in GameManager.players:
			send_player_info.rpc(GameManager.players[i].name, i)

@rpc("any_peer", "call_local")
func start_game():
	var scene = load("res://test_level.tscn").instantiate()
	get_tree().root.add_child(scene)
	self.hide()

# called on server and clients
func player_connected(id):
	print("Player " + str(id) + " connected.")
	
# called on server and clients
func player_disconnected(id):
	print("Player " + str(id) + " disconnected.")
	
# called only from clients
func connected_to_server():
	print("Connected to server!")
	send_player_info.rpc_id(1, $CenterContainer/VBoxContainer/LineEdit.text, multiplayer.get_unique_id())

# called only from clients
func connection_failed():
	print("Connection failed.")

func _on_host_button_button_down():
	peer = ENetMultiplayerPeer.new()
	var error = peer.create_server(port, 10)
	if error != OK:
		print("Could not host: Error " + str(error))
		return
	
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	
	multiplayer.set_multiplayer_peer(peer)
	print("Waiting for Players...")
	

func _on_join_button_button_down(): 
	peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	peer.get_host().compress(ENetConnection.COMPRESS_RANGE_CODER)
	multiplayer.set_multiplayer_peer(peer)


func _on_start_button_button_down():
	start_game.rpc()
