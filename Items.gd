extends Node

var items = {
	"default-knife": {
		"type": "knife",
		"damage": 25,
		"firing-mode": "semi-automatic",
		"sprite": "res://assets/knives/default-knife.png"
	},
	"ak-47": {
		"type": "primary",
		"display-name": "AK-47",
		"price": 2700,
		"damage": 36,
		"spread": 0.2,
		"magazine-capacity": 30,
		"magazine-ammo": 30,
		"reserve-ammo": 90,
		"purchasable-by": "T",
		"reload-time": 2.4,
		"rate-of-fire": 600, # measured in rounds per minute
		"firing-mode": "automatic",
		"sprite": "res://assets/guns/ak-47.png"
	},
	"m4a4": {
		"type": "primary",
		"display-name": "M4A4",
		"price": 3100,
		"damage": 33,
		"spread": 0.2,
		"magazine-capacity": 30,
		"magazine-ammo": 30,
		"reserve-ammo": 90,
		"purchasable-by": "CT",
		"reload-time": 3.1,
		"rate-of-fire": 666,
		"firing-mode": "automatic",
		"sprite": "res://assets/guns/m4a4.png"
	},
	"sg-553": {
		"type": "primary",
		"display-name": "SG 553",
		"price": 3000,
		"damage": 30,
		"spread": 0.2,
		"magazine-capacity": 30,
		"magazine-ammo": 30,
		"reserve-ammo": 90,
		"purchasable-by": "T",
		"reload-time": 2.8,
		"rate-of-fire": 545,
		"firing-mode": "automatic",
		"sprite": "res://assets/guns/sg-553.png"
	},
	"aug": {
		"type": "primary",
		"display-name": "AUG",
		"price": 3300,
		"damage": 28,
		"spread": 0.2,
		"magazine-capacity": 30,
		"magazine-ammo": 30,
		"reserve-ammo": 90,
		"purchasable-by": "CT",
		"reload-time": 3.8,
		"rate-of-fire": 600,
		"firing-mode": "automatic",
		"sprite": "res://assets/guns/aug.png"
	},
	"awp": {
		"type": "primary",
		"display-name": "AWP",
		"price": 4750,
		"damage": 115,
		"spread": 0.2,
		"magazine-capacity": 5,
		"magazine-ammo": 5,
		"reserve-ammo": 30,
		"purchasable-by": "BOTH",
		"reload-time": 3.7,
		"rate-of-fire": 41,
		"firing-mode": "bolt-action",
		"sprite": "res://assets/guns/awp.png"
	},
	"ssg-08": {
		"type": "primary",
		"display-name": "SSG 08",
		"price": 1700,
		"damage": 88,
		"spread": 0.2,
		"magazine-capacity": 10,
		"magazine-ammo": 10,
		"reserve-ammo": 90,
		"purchasable-by": "BOTH",
		"reload-time": 3.7,
		"rate-of-fire": 48,
		"firing-mode": "bolt-action",
		"sprite": "res://assets/guns/ssg-08.png"
	},
	"glock-18": {
		"type": "secondary",
		"display-name": "Glock 18",
		"price": 400,
		"damage": 30,
		"spread": 0.15,
		"magazine-capacity": 20,
		"magazine-ammo": 20,
		"reserve-ammo": 120,
		"purchasable-by": "T",
		"reload-time": 2.3,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": "res://assets/guns/glock-18.png"
	},
	"usp": {
		"type": "secondary",
		"display-name": "USP",
		"price": 500,
		"damage": 33,
		"spread": 0.1,
		"magazine-capacity": 12,
		"magazine-ammo": 12,
		"reserve-ammo": 100,
		"purchasable-by": "CT",
		"reload-time": 2.7,
		"rate-of-fire": 400,
		"firing-mode": "semi-automatic",
		"sprite": "res://assets/guns/usp.png"
	},
	"deagle": {
		"type": "secondary",
		"display-name": "Deagle",
		"price": 700,
		"damage": 53,
		"spread": 0.3,
		"magazine-capacity": 7,
		"magazine-ammo": 7,
		"reserve-ammo": 35,
		"purchasable-by": "BOTH",
		"reload-time": 2.2,
		"rate-of-fire": 267,
		"firing-mode": "semi-automatic",
		"sprite": "res://assets/guns/deagle.png"
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
