extends CharacterBody2D

const MAX_SPEED = 400

func _physics_process(delta):
	follow_mouse()
	movement(delta)
	
	move_and_slide()
	
func movement(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * MAX_SPEED

func follow_mouse():
	look_at(get_global_mouse_position())
	rotation_degrees += 90
