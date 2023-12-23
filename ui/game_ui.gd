extends CanvasLayer

func _ready():
	GameValues.message_sent.connect(_on_message_sent)

func _on_line_edit_text_submitted(new_text):
	var id = multiplayer.get_unique_id()
	var username
	if multiplayer.is_server():
		username = "SERVER"
	else:
		username = GameValues.players[id].username
		
	GameValues.send_message.rpc(new_text, username)
	$MessageLine.text = ""
	$MessageLine.release_focus()

func _on_message_line_focus_entered():
	GameValues.typing = true

func _on_message_line_focus_exited():
	GameValues.typing = false

func _on_message_sent():
	$Messages.text = GameValues.messages
