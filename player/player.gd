extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot

const MAX_SPEED := 400
var player_name = "Guest"

func _ready():
	print("Player spawned.")

func _enter_tree():
	set_multiplayer_authority(name.to_int())

func _physics_process(_delta):
	if is_multiplayer_authority():
		follow_mouse()
		movement()
		
	move_and_slide()
	
func movement():
	var input_direction = Input.get_vector("left", "right", "up", "down").normalized()
	velocity = input_direction * MAX_SPEED

func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90
