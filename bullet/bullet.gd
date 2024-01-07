extends Area2D

var speed := 700.0
var bullet_direction := Vector2.ZERO
var velocity := Vector2.ZERO
var damage = 40
var team = "CT"
var player_id = 0

func _ready():
	velocity = bullet_direction * speed

func _physics_process(delta):
	global_position += velocity * delta

func _on_body_entered(body):
	if body is CharacterBody2D == false:
		queue_free()
