extends Button

@export var buy_item := "ak-47"

var price

func _ready():
	price = Items.items[buy_item]["price"]
	text = Items.items[buy_item]["display-name"] + "\n" + "$" + str(price)

func _on_pressed():
	if price <= GameValues.player_money:
		GameValues.player_money -= price
		
