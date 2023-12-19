extends CharacterBody2D

@onready var rotation_pivot = $RotationPivot

const MAX_SPEED := 400
var player_name: String

@export var player := 1 :
	set(id):
		player = id
		# Give authority over the player input to the appropriate peer.
		$PlayerInput.set_multiplayer_authority(id)
		print(id)
		
@onready var input = $PlayerInput

func _ready():
	#print("Player spawned. Name: %s, position: %s" % [player_name, position])
	if player == multiplayer.get_unique_id():
		$Camera2D.enabled = true

func _physics_process(delta):
	follow_mouse()
	movement(delta)
	
	move_and_slide()
	
func movement(delta):
	var input_direction = input.direction.normalized()
	velocity = input_direction * MAX_SPEED

func follow_mouse():
	rotation_pivot.look_at(get_global_mouse_position())
	rotation_pivot.rotation_degrees += 90
