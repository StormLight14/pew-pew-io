extends MultiplayerSynchronizer

@export var direction := Vector2()

func _ready():
	# Only process for the local player.
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())
	

func _process(delta):
	direction = Input.get_vector("left", "right", "up", "down")
