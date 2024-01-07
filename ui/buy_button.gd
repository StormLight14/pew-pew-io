extends Button

@export var buy_item = "ak-47"

func _ready():
	text = Items.items[buy_item]["display-name"] + "\n" + "$" + str(Items.items[buy_item]["price"])
