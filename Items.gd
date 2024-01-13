extends Node

var items = {
	"default-knife": {
		"type": "knife",
		"damage": 25,
		"firing-mode": "semi-automatic"
		#"sprite": preload("res://assets/knives/default.png")
	},
	"ak-47": {
		"type": "primary",
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
		"type": "primary",
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
		"type": "primary",
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
		"type": "primary",
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
		"type": "primary",
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
		"type": "primary",
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
		"type": "secondary",
		"display-name": "Glock 18",
		"price": 400,
		"damage": 30,
		"spread": 0.15,
		"magazine-capacity": 20,
		"reserve-ammo": 120,
		"purchasable-by": "T",
		"reload-time": 2.3,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": preload("res://assets/guns/gun.png")
	},
	"usp": {
		"type": "secondary",
		"display-name": "USP",
		"price": 500,
		"damage": 33,
		"spread": 0.1,
		"magazine-capacity": 12,
		"reserve-ammo": 100,
		"purchasable-by": "CT",
		"reload-time": 2.7,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": preload("res://assets/guns/gun.png")
	}
}


var default_t_items = {
	"primary": null,
	"secondary": items["glock-18"],
	"knife": items["default-knife"],
	"utility_1": null,
	"utility_2": null,
	"utility_3": null,
	"bomb": null,
}

var default_ct_items = {
	"primary": null,
	"secondary": items["usp"],
	"knife": items["default-knife"],
	"utility_1": null,
	"utility_2": null,
	"utility_3": null,
	"bomb": null,
}
