extends CanvasLayer

@onready var spectate_ui = $SpectateUI
@onready var spectate_label = %SpectateLabel
@onready var shop_ui = %ShopUI

func _ready():
	GameValues.message_sent_signal.connect(_on_message_sent)
	GameValues.player_killed_signal.connect(_on_player_killed)
	
func _process(_delta):
	if Input.is_action_just_pressed("buy_menu"):
		shop_ui.visible = not shop_ui.visible
		GameValues.shop_open = not GameValues.shop_open
		update_buy_menu()
		
func update_buy_menu():
	for buy_button in get_tree().get_nodes_in_group("BuyButton"):
		buy_button.disabled = true
		if (Items.items[buy_button.buy_item]["purchasable-by"] == GameValues.players[multiplayer.get_unique_id()].team or Items.items[buy_button.buy_item]["purchasable-by"] == "BOTH") and Items.items[buy_button.buy_item]["price"] <= GameValues.player_money:
			buy_button.disabled = false

func make_visible():
	self.visible = true
	if multiplayer.is_server():
		pass
	else:
		spectate_ui.visible = false

func _on_line_edit_text_submitted(new_text):
	var id = multiplayer.get_unique_id()
	var username
	
	if multiplayer.is_server():
		username = "SERVER"
	else:
		username = GameValues.players[id].username
		
	GameValues.send_message.rpc(new_text, username)
	$MessageLine.text = ""
	$MessageLine.release_focus()

func _on_message_line_focus_entered():
	GameValues.typing = true

func _on_message_line_focus_exited():
	GameValues.typing = false

func _on_message_sent():
	%Messages.text = GameValues.messages
	
func _on_player_killed():
	if multiplayer.is_server() == false:
		%DeathsCount.text = str(GameValues.players[multiplayer.get_unique_id()].deaths)
		%KillsCount.text = str(GameValues.players[multiplayer.get_unique_id()].kills)

func _on_spectate_previous_pressed():
	pass # Replace with function body.

func _on_spectate_next_pressed():
	var biggest_id = 0
	
	for id in GameValues.players:
		if id > biggest_id:
			biggest_id = id
			
	for player in get_tree().get_nodes_in_group("Player"):
		if player.name == str(biggest_id):
			player.camera_2d.enabled = true
