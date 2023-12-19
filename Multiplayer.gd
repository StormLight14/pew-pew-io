extends Node

@export var port = 9595

func _ready():
	$Level.visible = false
	
	get_tree().paused = true
	multiplayer.server_relay = false

	if DisplayServer.get_name() == "headless":
			print("Automatically starting dedicated server.")
			_on_host_pressed.call_deferred()

func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(port, 10)
	
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer server.")
		return
	multiplayer.multiplayer_peer = peer
	
	$UI/Net/Options/Start.disabled = false
	
func _on_start_pressed():
	start_game()

func _on_connect_pressed():
	var address = $UI/Net/Options/Remote.text
	if address == "":
		OS.alert("Need an address to connect to.")
		return
	
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(address, port)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
		return
		
	multiplayer.multiplayer_peer = peer
	start_game()

func start_game():
	$UI.hide()
	$Level.visible = true
	get_tree().paused = false
	
	if multiplayer.is_server():
		change_level.call_deferred(load("res://world.tscn"))

func change_level(scene: PackedScene):
	# Remove old level if any.
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	# Add new level.
	level.add_child(scene.instantiate())
