extends Node

var items = {
	"default_knife": {
		"type": "knife",
		"damage": 25,
		"firing_mode": "semi_automatic",
		"sprite": "res://assets/knives/default_knife.png"
	},
	"ak_47": {
		"type": "primary",
		"display_name": "AK_47",
		"price": 2700,
		"damage": 36,
		"spread": 0.2,
		"magazine_capacity": 30,
		"magazine_ammo": 30,
		"reserve_ammo": 90,
		"purchasable_by": "T",
		"reload_time": 2.4,
		"rate_of_fire": 600, # measured in rounds per minute
		"firing_mode": "automatic",
		"sprite": "res://assets/guns/ak_47.png"
	},
	"m4a4": {
		"type": "primary",
		"display_name": "M4A4",
		"price": 3100,
		"damage": 33,
		"spread": 0.2,
		"magazine_capacity": 30,
		"magazine_ammo": 30,
		"reserve_ammo": 90,
		"purchasable_by": "CT",
		"reload_time": 3.1,
		"rate_of_fire": 666,
		"firing_mode": "automatic",
		"sprite": "res://assets/guns/m4a4.png"
	},
	"sg_553": {
		"type": "primary",
		"display_name": "SG 553",
		"price": 3000,
		"damage": 30,
		"spread": 0.2,
		"magazine_capacity": 30,
		"magazine_ammo": 30,
		"reserve_ammo": 90,
		"purchasable_by": "T",
		"reload_time": 2.8,
		"rate_of_fire": 545,
		"firing_mode": "automatic",
		"sprite": "res://assets/guns/sg_553.png"
	},
	"aug": {
		"type": "primary",
		"display_name": "AUG",
		"price": 3300,
		"damage": 28,
		"spread": 0.2,
		"magazine_capacity": 30,
		"magazine_ammo": 30,
		"reserve_ammo": 90,
		"purchasable_by": "CT",
		"reload_time": 3.8,
		"rate_of_fire": 600,
		"firing_mode": "automatic",
		"sprite": "res://assets/guns/aug.png"
	},
	"awp": {
		"type": "primary",
		"display_name": "AWP",
		"price": 4750,
		"damage": 115,
		"spread": 0.2,
		"magazine_capacity": 5,
		"magazine_ammo": 5,
		"reserve_ammo": 30,
		"purchasable_by": "BOTH",
		"reload_time": 3.7,
		"rate_of_fire": 41,
		"firing_mode": "bolt_action",
		"sprite": "res://assets/guns/awp.png"
	},
	"ssg_08": {
		"type": "primary",
		"display_name": "SSG 08",
		"price": 1700,
		"damage": 88,
		"spread": 0.2,
		"magazine_capacity": 10,
		"magazine_ammo": 10,
		"reserve_ammo": 90,
		"purchasable_by": "BOTH",
		"reload_time": 3.7,
		"rate_of_fire": 48,
		"firing_mode": "bolt_action",
		"sprite": "res://assets/guns/ssg_08.png"
	},
	"glock_18": {
		"type": "secondary",
		"display_name": "Glock 18",
		"price": 400,
		"damage": 30,
		"spread": 0.15,
		"magazine_capacity": 20,
		"magazine_ammo": 20,
		"reserve_ammo": 120,
		"purchasable_by": "T",
		"reload_time": 2.3,
		"rate_of_fire": 400,
		"firing_mode": "semi_automatic",
		"sprite": "res://assets/guns/glock_18.png"
	},
	"usp": {
		"type": "secondary",
		"display_name": "USP",
		"price": 500,
		"damage": 33,
		"spread": 0.1,
		"magazine_capacity": 12,
		"magazine_ammo": 12,
		"reserve_ammo": 100,
		"purchasable_by": "CT",
		"reload_time": 2.7,
		"rate_of_fire": 400,
		"firing_mode": "semi_automatic",
		"sprite": "res://assets/guns/usp.png"
	},
	"deagle": {
		"type": "secondary",
		"display_name": "Deagle",
		"price": 700,
		"damage": 53,
		"spread": 0.3,
		"magazine_capacity": 7,
		"magazine_ammo": 7,
		"reserve_ammo": 35,
		"purchasable_by": "BOTH",
		"reload_time": 2.2,
		"rate_of_fire": 267,
		"firing_mode": "semi_automatic",
		"sprite": "res://assets/guns/deagle.png"
	},
	"bomb": {
		"type": "bomb",
		"place_time": 5,
		"detonate_time": 15,
		"firing_mode": "bomb",
		"sprite": "res://assets/bomb/bomb_item.png"
	}
}


var default_t_items = {
	"primary": null,
	"secondary": items["glock_18"],
	"knife": items["default_knife"],
	"utility_1": null,
	"utility_2": null,
	"utility_3": null,
	"bomb": null,
}

var default_ct_items = {
	"primary": null,
	"secondary": items["usp"],
	"knife": items["default_knife"],
	"utility_1": null,
	"utility_2": null,
	"utility_3": null,
	"bomb": null,
}
