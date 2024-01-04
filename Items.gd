extends Node

var items = {
	"guns": {
		"rifles": {
			"ak-47": {
				"price": 2700,
				"damage": 36,
				"magazine-capacity": 30,
				"reserve-ammo": 90,
				"purchasable-by": "T",
				"reload-time": 2.4,
				"firing-mode": "automatic",
				"sprite": preload("res://assets/guns/gun.png")
			},
			"m4a4": {
				"price": 3100,
				"damage": 33,
				"magazine-capacity": 30,
				"reserve-ammo": 90,
				"purchasable-by": "CT",
				"reload-time": 3.1,
				"firing-mode": "automatic",
				"sprite": preload("res://assets/guns/gun.png")
			},
			"sg-553": {
				"price": 3000,
				"damage": 30,
				"magazine-capacity": 30,
				"reserve-ammo": 90,
				"purchasable-by": "T",
				"reload-time": 2.8,
				"firing-mode": "automatic",
				"sprite": preload("res://assets/guns/gun.png")
			},
			"aug": {
				"price": 3300,
				"damage": 28,
				"magazine-capacity": 30,
				"reserve-ammo": 90,
				"purchasable-by": "CT",
				"reload-time": 3.8,
				"firing-mode": "automatic",
				"sprite": preload("res://assets/guns/gun.png")
			},
			"awp": {
				"price": 4750,
				"damage": 115,
				"magazine-capacity": 5,
				"reserve-ammo": 30,
				"purchasable-by": "BOTH",
				"reload-time": 3.7,
				"firing-mode": "bolt-action",
				"sprite": preload("res://assets/guns/gun.png")
			},
			"ssg-08": {
				"price": 1700,
				"damage": 88,
				"magazine-capacity": 10,
				"reserve-ammo": 90,
				"purchasable-by": "BOTH",
				"reload-time": 3.7,
				"firing-mode": "bolt-action",
				"sprite": preload("res://assets/guns/gun.png")
			}
		}
	}
}
