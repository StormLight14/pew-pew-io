extends Node2D

@onready var port = %Port
@onready var address = %Address
@onready var start = %Start
@onready var start_timer = %StartTimer

@export var player_scene: PackedScene

var peer = ENetMultiplayerPeer.new()

func _ready():
	get_tree().paused = true
	multiplayer.connected_to_server.connect(connected_to_server)
	$Players.visible = false
	$GameUI.visible = false
	
	if "--headless" in OS.get_cmdline_args():
		host_game(port.text.to_int())
		start_timer.start()


func _on_host_pressed():
	host_game(port.text.to_int())
	start.disabled = false

func _on_start_pressed():
	start_game.rpc()
	
func _on_start_timer_timeout():
	start_game.rpc()


func _on_join_pressed():
	join_game(address.text, port.text.to_int())
	
func connected_to_server():
	send_player_info.rpc_id(1, "Guest " + str(multiplayer.get_unique_id()), multiplayer.get_unique_id())
	pass

func host_game(port: int):
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	
func join_game(address: String, port: int):
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	
func add_players():
	for i in GameValues.players:
		var player = player_scene.instantiate()
		player.name = str(i)
		player.username = GameValues.players[i].username
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
			
	print(GameValues.players)

@rpc("any_peer", "call_local", "reliable")
func start_game():
	add_players()
	
	get_tree().paused = false
	$MenuUI.visible = false
	$GameUI.visible = true
	
	$Level.visible = true
	$Players.visible = true

func _on_username_text_changed(new_text):
	pass


