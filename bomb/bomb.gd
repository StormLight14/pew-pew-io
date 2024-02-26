extends Node2D

@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var beep_timer = $BeepTimer
@onready var bomb_beep_sound = $BombBeepSound
@onready var bomb_explode_sound = $BombExplodeSound
@onready var bomb_defused_sound = $BombDefusedSound

var exploded = false
var object_type = "bomb"

func _ready():
	animated_sprite_2d.play("active")
	GameValues.bomb_active = true
	
func _process(_delta):
	if bomb_explode_sound.get_playback_position() >= 2.1 and GameValues.bomb_active:
		beep_timer.stop()
		on_explode.rpc()

func defuse():
	GameValues.bomb_active = false
	beep_timer.stop()
	bomb_explode_sound.playing = false
	bomb_defused_sound.play()
	
	for level in get_tree().get_nodes_in_group("Level"):
		level.start_post_round("CT")

@rpc("any_peer", "call_local", "reliable")
func on_explode():
	for level in get_tree().get_nodes_in_group("Level"):
		level.start_post_round("T")
		visible = false
		
	for player in get_tree().get_nodes_in_group("Player"):
		if not exploded:
			var damage = 200 - global_position.distance_to(player.global_position) / 5
			if damage > 0:
				player.damage(damage, "bomb")
		
	GameValues.bomb_exploded = true
	exploded = true

func _on_beep_timer_timeout():
	bomb_beep_sound.play()
	if beep_timer.wait_time > (0.2 * 0.95):
		beep_timer.wait_time *= 0.95
		beep_timer.start()
	elif beep_timer.wait_time > 0.2:
		beep_timer.wait_time = 0.2
		beep_timer.start()
	else:
		bomb_explode_sound.play()
