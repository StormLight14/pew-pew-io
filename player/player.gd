extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot
@onready var username_label = $Username
@onready var team_label = $Team
@onready var bullet_spawn_point = $RotationPivot/BulletSpawnPoint
@onready var attack_delay = $AttackDelay
@onready var health_bar = $HealthBar
@onready var hurt_delay = $Hurtbox/HurtDelay
@onready var camera_2d = $Camera2D

const MAX_SPEED := 250

var username = "Guest"
var team = "T"
var health = 100
var max_health = health

var alive = true
var can_attack = true

var index = 0
var spawn_pos = Vector2.ZERO
var inventory_items = {
	"primary": null,
	"secondary": Items.items["glock-18"],
	"knife": Items.items["default-knife"],
	"utility_1": null,
	"utility_2": null,
	"utility_3": null,
	"bomb": null,
}
var equipped_item = "primary"

signal create_bullet(bullet_scene)
	
func _enter_tree():
	set_multiplayer_authority(name.to_int())
	GameValues.players[name.to_int()].team = team
	
func _ready():
	if index == 1:
		pass # give bomb
	
	for spawn_position in get_tree().get_nodes_in_group("SpawnPoint"):
		if spawn_position.name == str(index):
			global_position = spawn_position.global_position
	spawn_pos = global_position
	
	health_bar.value = self.health
	health_bar.max_value = self.health
	team_label.text = team
	
	if is_multiplayer_authority():
		$PlayerLight.visible = true
		username_label.text = username
		camera_2d.enabled = true

func _physics_process(_delta):
	if modulate != Color(1, 1, 1, 1):
		visible = false
		
	if is_multiplayer_authority():
		follow_mouse()
		
		if GameValues.typing == false:
			if GameValues.can_interact and GameValues.shop_open == false:
				attack()
				movement()
			
			switch_inventory_slot()
			
			if GameValues.can_interact:
				move_and_slide()

func movement():
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * MAX_SPEED
	
func switch_inventory_slot():
	if Input.is_action_just_pressed("primary"):
		equipped_item = "primary"
	elif Input.is_action_just_pressed("secondary"):
		equipped_item = "secondary"
	elif Input.is_action_just_pressed("knife"):
		equipped_item = "knife"
	
func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90

func attack():
	var item_dict = inventory_items[equipped_item]
	if item_dict:
		var item_is_gun = item_dict["type"] == "gun"
		
		if item_is_gun:
			var attack_delay_time = 60.0/item_dict["rate-of-fire"]

			if attack_delay_time:
				attack_delay.wait_time = attack_delay_time

		if attack_delay.is_stopped() == true:
			if (item_dict["firing-mode"] == "semi-automatic" or item_dict["firing-mode"] == "bolt-action") and Input.is_action_just_pressed("attack"):
				attack_delay.start()
				
				if item_is_gun:
					spawn_bullet.rpc((global_position.direction_to(bullet_spawn_point.global_position)).rotated(get_spread_angle()), inventory_items[equipped_item]["damage"], multiplayer.get_unique_id())
					%NoSpread.start(0.3)
					
			if item_dict["firing-mode"] == "automatic" and Input.is_action_pressed("attack"):
				attack_delay.start()
				
				if item_is_gun:
					spawn_bullet.rpc((global_position.direction_to(bullet_spawn_point.global_position)).rotated(get_spread_angle()), inventory_items[equipped_item]["damage"], multiplayer.get_unique_id())
					%NoSpread.start(0.3)

func get_spread_angle():
	var spread
	var spread_angle
	
	if %NoSpread.is_stopped() == false:
		spread = inventory_items[equipped_item]["spread"]
		spread_angle = RandomNumberGenerator.new().randf_range(-spread, spread)
	else:
		spread = 0
		spread_angle = 0
		
	return spread_angle

@rpc("any_peer", "call_local", "reliable")
func spawn_bullet(direction = Vector2.ZERO, damage = 0, player_id = 1):
	var bullet = load("res://bullet/bullet.tscn").instantiate()

	bullet.bullet_direction = direction
	bullet.global_position = bullet_spawn_point.global_position
	bullet.team = team
	bullet.player_id = player_id
	bullet.damage = damage
	
	get_parent().get_parent().add_child(bullet)

@rpc("any_peer", "call_local", "reliable")
func respawn():
	visible = true
	set_collisions(true)
	global_position = spawn_pos
	health = max_health
	health_bar.value = health

func _on_hurtbox_area_entered(area):
	if area.team != team:
		area.queue_free()
			
		if hurt_delay.is_stopped() == true:
			hurt_delay.start()
			health -= area.damage
			health_bar.value = health
			
			if health <= 0:
				if multiplayer.is_server():
					GameValues.player_killed.rpc(area.player_id, name.to_int())
				alive = false
				visible = false
				set_collisions(false)
				
				if multiplayer.is_server():
					GameValues.send_message.rpc(username + " has been killed.", "SERVER")

func set_collisions(boolean):
	%Hurtbox.set_deferred("monitoring", boolean)
