extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot
@onready var username_label = $Username
@onready var team_label = $Team
@onready var bullet_spawn_point = $RotationPivot/BulletSpawnPoint
@onready var attack_delay = $AttackDelay
@onready var health_bar = $HealthBar
@onready var hurt_delay = $Hurtbox/HurtDelay
@onready var camera_2d = $Camera2D

const MAX_SPEED := 400

var username = "Guest"
var team = "T"
var health = 100
var max_health = health

var alive = true
var can_attack = true

var index = 0
var spawn_pos = Vector2.ZERO
var items = []

signal create_bullet(bullet_scene)
	
func _enter_tree():
	set_multiplayer_authority(name.to_int())
	
func _ready():
	if index == 1:
		items.append("bomb")
	
	for spawn_position in get_tree().get_nodes_in_group("SpawnPoint"):
		if spawn_position.name == str(index):
			global_position = spawn_position.global_position
	spawn_pos = global_position
	
	health_bar.value = self.health
	health_bar.max_value = self.health
	team_label.text = team
	
	if is_multiplayer_authority():
		username_label.text = username
		camera_2d.enabled = true

func _physics_process(_delta):
	if is_multiplayer_authority():
		follow_mouse()
		
		if GameValues.can_interact:
			if GameValues.typing == false:
				attack()
				movement()
			
			move_and_slide()

func movement():
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * MAX_SPEED

func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90

func attack():
	if Input.is_action_just_pressed("attack"):
		if attack_delay.is_stopped() == true:
			attack_delay.start()
			spawn_bullet.rpc(global_position.direction_to(bullet_spawn_point.global_position), multiplayer.get_unique_id())
			
@rpc("any_peer", "call_local", "reliable")
func spawn_bullet(direction = Vector2.ZERO, player_id = 1):
	var bullet = load("res://bullet/bullet.tscn").instantiate()
	bullet.bullet_direction = direction
	bullet.global_position = bullet_spawn_point.global_position
	bullet.team = team
	bullet.player_id = player_id

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
