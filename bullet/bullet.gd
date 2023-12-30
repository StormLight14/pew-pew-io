extends Area2D

var speed := 300.0
var bullet_direction := Vector2.ZERO
var velocity := Vector2.ZERO
var damage = 40
var team = "CT"
var player_id = 0

func _physics_process(delta):
	velocity = (bullet_direction).normalized()  * speed
	global_position += velocity * delta

func _on_body_entered(body):
	if body.is_obstacle:
		queue_free()
