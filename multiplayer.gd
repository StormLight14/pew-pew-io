extends Node2D

@onready var port = %Port
@onready var address = %Address
@onready var start = %Start
@onready var username = %Username

@export var player_scene: PackedScene

var peer = ENetMultiplayerPeer.new()
var players = []

func _ready():
	get_tree().paused = true
	$Players.visible = false
	$GameUI.visible = false

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
	print("Added player with id: ", id)
	var player = player_scene.instantiate()
	player.name = str(id)
	player.player_name = GameValues.player_name
	
	players.append(player)

@rpc("any_peer", "call_local", "reliable")
func start_game():
	for player in players:
		player.player_name = GameValues.player_name
		$Players.add_child(player)
		
	get_tree().paused = false
	$MenuUI.visible = false
	$GameUI.visible = true
	
	$Level.visible = true
	$Players.visible = true

func _on_username_text_changed(new_text):
	if new_text != "" and new_text != "Guest":
		GameValues.player_name = new_text
	else:
		GameValues.player_name = "Guest " + str(multiplayer.get_unique_id())

