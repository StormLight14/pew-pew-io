extends Area2D

var speed := 300.0

var bullet_direction := Vector2.ZERO
var velocity := Vector2.ZERO
var damage = 15
var team = "CT"

func _physics_process(delta):
	velocity = (bullet_direction).normalized()  * speed
	
	global_position += velocity * delta
