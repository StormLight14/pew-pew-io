extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot
@onready var username = $Username
@onready var bullet_spawn_point = $RotationPivot/BulletSpawnPoint
@onready var attack_delay = $AttackDelay
@onready var health_bar = $HealthBar

const MAX_SPEED := 400
var player_name = "Guest"
var team = "T"
var health = 200
var max_health = health

var can_attack = true

#signal spawn_bullet(bullet_scene)
	
func _enter_tree():
	set_multiplayer_authority(name.to_int())
	
func _ready():
	health_bar.value = self.health
	health_bar.max_value = self.health
	
	if is_multiplayer_authority():
		username.text = GameValues.player_name

func _physics_process(_delta):
	if is_multiplayer_authority():
		follow_mouse()
		
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
			#print("pew from player: ", player_name)

			spawn_bullet.rpc(bullet_spawn_point.global_position.direction_to(get_global_mouse_position()))
			
@rpc("any_peer", "call_local", "reliable")
func spawn_bullet(direction = Vector2.ZERO):
	var bullet = load("res://bullet/bullet.tscn").instantiate()
	bullet.bullet_direction = direction
	bullet.global_position = bullet_spawn_point.global_position
	get_node("../../Level").add_child(bullet)
	
@rpc("any_peer", "call_local", "reliable")
func respawn():
	global_position = Vector2(0, 0)
	health = max_health
	health_bar.value = health
	
	GameValues.send_message(player_name + " has been killed.", "SERVER")

func _on_hurtbox_area_entered(area):
	if area.team != team:
		area.queue_free()
		health -= area.damage
		health_bar.value = health
		
		if health <= 0:
			respawn.rpc()
