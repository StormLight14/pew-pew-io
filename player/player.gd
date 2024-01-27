extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot
@onready var username_label = $Username
@onready var team_label = $Team
@onready var bullet_spawn_point = $RotationPivot/BulletSpawnPoint
@onready var attack_delay = $AttackDelay
@onready var health_bar = $HealthBar
@onready var hurt_delay = $Hurtbox/HurtDelay
@onready var camera_2d = $Camera2D
@onready var gun_sprite = %GunSprite

const MAX_SPEED := 250

var username = "Guest"
var team = "T"
var health = 100
var max_health = health

var alive = true

var index = 0
var spawn_pos = Vector2.ZERO

var id

signal create_bullet(bullet_scene)
	
func _enter_tree():
	set_multiplayer_authority(id)
	GameValues.players[id].team = team
	
func _ready():
	for spawn_position in get_tree().get_nodes_in_group("SpawnPoint"):
		if spawn_position.name == str(index):
			global_position = spawn_position.global_position
	spawn_pos = global_position
	
	health_bar.value = self.health
	health_bar.max_value = self.health
	team_label.text = team
	
	if is_multiplayer_authority():
		#$PlayerLight.visible = true
		username_label.text = username
		camera_2d.enabled = true
		GameValues.change_player_stat.rpc(id, "equipped_item", GameValues.players[id].equipped_item)
		GameValues.update_ammo_ui.emit()

func _physics_process(_delta):
	if is_multiplayer_authority() and alive:
		follow_mouse()
		
		if GameValues.typing == false:
			if GameValues.can_interact and GameValues.shop_open == false:
				attack()
				movement()
				reload_gun()
			
			switch_inventory_slot()
			
			if GameValues.can_interact:
				move_and_slide()

func movement():
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * MAX_SPEED
	
func switch_inventory_slot():
	var change_item = null
	
	if %ReloadDelay.is_stopped():
		if Input.is_action_just_pressed("primary"):
			if GameValues.players[id].items.primary:
				change_item = "primary"
		elif Input.is_action_just_pressed("secondary"):
			if GameValues.players[id].items.secondary:
				change_item = "secondary"
		elif Input.is_action_just_pressed("knife"):
			if GameValues.players[id].items.knife:
				change_item = "knife"
		elif Input.is_action_just_pressed("bomb"):
			if GameValues.players[id].items.bomb:
				change_item = "bomb"
			
		if change_item:
			GameValues.change_player_stat.rpc(id, "equipped_item", change_item)
			GameValues.update_ammo_ui.emit()
	
func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90

func attack():
	var inventory_items = GameValues.players[id]["items"]
	var equipped_item = GameValues.players[id].equipped_item
	var item_dict = null
	
	if equipped_item in inventory_items:
		item_dict = inventory_items[equipped_item]
	
	if item_dict:
		var item_is_gun = (item_dict.type == "primary" or item_dict.type == "secondary")
		
		if item_is_gun:
			var attack_delay_time = 60.0/item_dict.rate_of_fire

			if attack_delay_time:
				attack_delay.wait_time = attack_delay_time
	
		if attack_delay.is_stopped() == true:
			if (item_dict.firing_mode == "semi_automatic" or item_dict.firing_mode == "bolt_action") and Input.is_action_just_pressed("attack"):
				if item_is_gun:
					if item_dict.magazine_ammo > 0:
						spawn_bullet.rpc((global_position.direction_to(bullet_spawn_point.global_position)).rotated(get_spread_angle()), inventory_items[equipped_item].damage, multiplayer.get_unique_id())
						%NoSpread.start(0.3)
						
						item_dict.magazine_ammo -= 1
						GameValues.update_ammo_ui.emit()
				attack_delay.start()
					
			if item_dict.firing_mode == "automatic" and Input.is_action_pressed("attack"):
				if item_is_gun:
					if item_dict.magazine_ammo > 0:
						spawn_bullet.rpc((global_position.direction_to(bullet_spawn_point.global_position)).rotated(get_spread_angle()), inventory_items[equipped_item].damage, multiplayer.get_unique_id())
						%NoSpread.start(0.3)
						
						item_dict.magazine_ammo -= 1
						GameValues.update_ammo_ui.emit()
				attack_delay.start()
				
					
func reload_gun():
	var inventory_items = GameValues.players[id].items
	var equipped_item = GameValues.players[id].equipped_item
	
	if equipped_item in inventory_items:
		var item_dict = inventory_items[equipped_item]
		
		if item_dict.type == "primary" or item_dict.type == "secondary":
			if item_dict.magazine_ammo == 0 or Input.is_action_just_pressed("reload"):
				if %ReloadDelay.is_stopped() == true and (item_dict.magazine_ammo == 0 and item_dict.reserve_ammo == 0) == false:
					%ReloadDelay.wait_time = item_dict.reload_time
					%ReloadDelay.start()

func _on_reload_delay_timeout():
	var inventory_items = GameValues.players[id].items
	var equipped_item = GameValues.players[id].equipped_item
	
	if equipped_item in inventory_items:
		var item_dict = inventory_items[equipped_item]
		if item_dict.reserve_ammo >= item_dict.magazine_capacity:
			item_dict.magazine_ammo = item_dict.magazine_capacity
			item_dict.reserve_ammo -= item_dict.magazine_capacity

		elif item_dict.reserve_ammo > 0:
			item_dict.magazine_ammo = item_dict.reserve_ammo
			item_dict.reserve_ammo = 0
			
	GameValues.update_ammo_ui.emit()
	

func get_spread_angle():
	var inventory_items = GameValues.players[id]["items"]
	var equipped_item = GameValues.players[id].equipped_item
	var spread
	var spread_angle
	
	if %NoSpread.is_stopped() == false:
		spread = inventory_items[equipped_item].spread
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
	alive = true
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
				if team == "T":
					GameValues.change_player_stat.rpc(id, "items", Items.default_t_items)
				else:
					GameValues.change_player_stat.rpc(id, "items", Items.default_ct_items)
					
				if multiplayer.is_server():
					GameValues.player_killed.rpc(area.player_id, id)
				alive = false
				visible = false
				set_collisions(false)
				
				if multiplayer.is_server():
					GameValues.send_message.rpc(username + " has been killed.", "SERVER", 1)

func set_collisions(boolean):
	%Hurtbox.set_deferred("monitoring", boolean)
