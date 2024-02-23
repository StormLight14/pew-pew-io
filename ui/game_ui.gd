extends CanvasLayer

@onready var spectate_ui = $SpectateUI
@onready var spectate_label = %SpectateLabel
@onready var shop_ui = %ShopUI
@onready var money_ui = %MoneyUI
@onready var money_label = %MoneyLabel
@onready var message_line = $MessageLine
@onready var inventory_label = %InventoryLabel

func _ready():
	GameValues.message_sent_signal.connect(_on_message_sent)
	GameValues.player_killed_signal.connect(_on_player_killed)
	GameValues.player_stat_changed_signal.connect(update_inventory_label)
	GameValues.update_ammo_ui.connect(update_ammo_ui)
	for buy_button in get_tree().get_nodes_in_group("BuyButton"):
		buy_button.buy_button_pressed.connect(_buy_button_pressed)
	
func _process(_delta):
	if Input.is_action_just_pressed("buy_menu") and GameValues.typing == false:
		shop_ui.visible = not shop_ui.visible
		GameValues.shop_open = not GameValues.shop_open
		update_buy_menu()
		
func update_ammo_ui():
	if multiplayer.is_server() == false:
		var inventory_items = GameValues.players[multiplayer.get_unique_id()].items
		var equipped_item = GameValues.players[multiplayer.get_unique_id()].equipped_item
		
		if equipped_item in inventory_items:
			var item_dict = inventory_items[equipped_item]
			if item_dict.type == "secondary" or item_dict.type == "primary":
				%Ammo.text = "Ammo: " + str(inventory_items[equipped_item].magazine_ammo)
				%ReserveAmmo.text = "Reserve Ammo: " + str(inventory_items[equipped_item].reserve_ammo)
			else:
				%Ammo.text = ""
				%ReserveAmmo.text = ""
func update_buy_menu():
	for buy_button in get_tree().get_nodes_in_group("BuyButton"):
		buy_button.disabled = true
		buy_button.visible = false
		if (Items.items[buy_button.buy_item].purchasable_by == GameValues.players[multiplayer.get_unique_id()].team or Items.items[buy_button.buy_item].purchasable_by == "BOTH"):
			buy_button.visible = true
		if (Items.items[buy_button.buy_item].price <= GameValues.player_money):
			buy_button.disabled = false
			
func update_money_label():
	money_label.text = "$" + str(GameValues.player_money)
	
func update_inventory_label():
	if not multiplayer.is_server():
		var player_inventory = GameValues.players[multiplayer.get_unique_id()].items
		var primary_name = null
		var secondary_name = null
		
		inventory_label.text = ""
		
		if player_inventory.primary:
			primary_name = player_inventory.primary.display_name
			inventory_label.text += "[1] - " + primary_name + "\n"
		if player_inventory.secondary:
			secondary_name = player_inventory.secondary.display_name
			inventory_label.text += "[2] - " + secondary_name + "\n"
		inventory_label.text += "[3] - Knife" + "\n"
		if player_inventory.bomb:
			inventory_label.text += "[5] - Bomb\n"

func make_visible():
	self.visible = true
	if multiplayer.is_server():
		pass
	else:
		spectate_ui.visible = false
		
func _buy_button_pressed():
	update_money_label()

func _on_line_edit_text_submitted(new_text):
	var player_id = multiplayer.get_unique_id()
	var username
	
	if multiplayer.is_server():
		username = "SERVER"
	else:
		username = GameValues.players[player_id].username
	
	if multiplayer.is_server() == false:
		new_text = strip_bbcode(new_text)
		
	GameValues.send_message.rpc(new_text, username, player_id)
	$MessageLine.text = ""
	$MessageLine.release_focus()
	
func strip_bbcode(source:String) -> String:
	var regex = RegEx.new()
	regex.compile("\\[.+?\\]")
	return regex.sub(source, "", true)

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
		if player.id == biggest_id:
			player.camera_2d.enabled = true
