extends Node

var items = {
	"default-knife": {
		"type": "knife",
		"damage": 25,
		"firing-mode": "semi-automatic"
		#"sprite": preload("res://assets/knives/default.png")
	},
	"ak-47": {
		"type": "gun",
		"display-name": "AK-47",
		"price": 2700,
		"damage": 36,
		"spread": 0.2,
		"magazine-capacity": 30,
		"reserve-ammo": 90,
		"purchasable-by": "T",
		"reload-time": 2.4,
		"rate-of-fire": 600, # measured in rounds per minute
		"firing-mode": "automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"m4a4": {
		"type": "gun",
		"display-name": "M4A4",
		"price": 3100,
		"damage": 33,
		"spread": 0.2,
		"magazine-capacity": 30,
		"reserve-ammo": 90,
		"purchasable-by": "CT",
		"reload-time": 3.1,
		"rate-of-fire": 666,
		"firing-mode": "automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"sg-553": {
		"type": "gun",
		"display-name": "SG 553",
		"price": 3000,
		"damage": 30,
		"spread": 0.2,
		"magazine-capacity": 30,
		"reserve-ammo": 90,
		"purchasable-by": "T",
		"reload-time": 2.8,
		"rate-of-fire": 545,
		"firing-mode": "automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"aug": {
		"type": "gun",
		"display-name": "AUG",
		"price": 3300,
		"damage": 28,
		"spread": 0.2,
		"magazine-capacity": 30,
		"reserve-ammo": 90,
		"purchasable-by": "CT",
		"reload-time": 3.8,
		"rate-of-fire": 600,
		"firing-mode": "automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"awp": {
		"type": "gun",
		"display-name": "AWP",
		"price": 4750,
		"damage": 115,
		"spread": 0.2,
		"magazine-capacity": 5,
		"reserve-ammo": 30,
		"purchasable-by": "BOTH",
		"reload-time": 3.7,
		"rate-of-fire": 41,
		"firing-mode": "bolt-action",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"ssg-08": {
		"type": "gun",
		"display-name": "SSG 08",
		"price": 1700,
		"damage": 88,
		"spread": 0.2,
		"magazine-capacity": 10,
		"reserve-ammo": 90,
		"purchasable-by": "BOTH",
		"reload-time": 3.7,
		"rate-of-fire": 48,
		"firing-mode": "bolt-action",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"glock-18": {
		"type": "gun",
		"display-name": "Glock 18",
		"price": 400,
		"damage": 30,
		"spread": 0.2,
		"magazine-capacity": 20,
		"reserve-ammo": 120,
		"purchasable-by": "T",
		"reload-time": 2.3,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"usp": {
		"type": "gun",
		"display-name": "USP",
		"price": 500,
		"damage": 33,
		"spread": 0.2,
		"magazine-capacity": 12,
		"reserve-ammo": 100,
		"purchasable-by": "CT",
		"reload-time": 2.7,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": preload("res://assets/guns/gun.png")
	}
}
