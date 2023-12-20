extends Node2D

@onready var port = %Port
@onready var address = %Address
@onready var start = %Start

@export var player_scene: PackedScene

var player_name = "Guest"

var peer = ENetMultiplayerPeer.new()

func _ready():
	$Players.visible = false
	$GameUI.visible = false
	
	$GameUI.message_sent.connect(_message_sent)

func _on_host_pressed():
	host_game(port.text.to_int())
	start.disabled = false

func _on_start_pressed():
	start_game.rpc()

func _on_join_pressed():
	join_game(address.text, port.text.to_int())
	
func host_game(port: int):
	peer.create_server(port)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	
func join_game(address: String, port: int):
	peer.create_client(address, port)
	multiplayer.multiplayer_peer = peer
	
func add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	player.player_name = player
	$Players.add_child(player)

@rpc("any_peer", "call_local", "reliable")
func start_game():
	$MenuUI.visible = false
	$GameUI.visible = true
	
	$Level.visible = true
	$Players.visible = true

@rpc("any_peer", "call_local", "reliable")
func send_message(message = ""):
	$GameUI/Messages.text += "Some User" + ": " + message + "\n"
	
func _message_sent(message):
	send_message.rpc(message)

func _on_username_text_submitted(new_text):
	player_name = new_text
