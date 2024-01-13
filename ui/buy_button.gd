extends Button

@export var buy_item := "ak-47"

signal buy_button_pressed

var price
var item_type

func _ready():
	price = Items.items[buy_item]["price"]
	item_type = Items.items[buy_item]["type"]
	text = Items.items[buy_item]["display-name"] + "\n" + "$" + str(price)

func _on_pressed():
	var current_items = GameValues.players[multiplayer.get_unique_id()].items
	
	if price <= GameValues.player_money:
		GameValues.player_money -= price
		current_items[item_type] = Items.items[buy_item]
		print(current_items)
		GameValues.change_player_stat.rpc(multiplayer.get_unique_id(), "items", current_items)
		buy_button_pressed.emit()
