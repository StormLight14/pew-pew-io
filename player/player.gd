extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot

const MAX_SPEED = 400

func _ready():
	$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())

func _physics_process(delta):
	if $MultiplayerSynchronizer.get_multiplayer_authority() == multiplayer.get_unique_id():
		follow_mouse()
		movement(delta)
		
		move_and_slide()
	
func movement(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * MAX_SPEED

func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90
