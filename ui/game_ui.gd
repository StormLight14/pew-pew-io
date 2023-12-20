extends CanvasLayer

func _ready():
	GameValues.message_sent.connect(_on_message_sent)

func _on_line_edit_text_submitted(new_text):
	GameValues.send_message.rpc(new_text, GameValues.player_name)
	$MessageLine.text = ""
	$MessageLine.release_focus()

func _on_message_line_focus_entered():
	GameValues.typing = true

func _on_message_line_focus_exited():
	GameValues.typing = false

func _on_message_sent():
	$Messages.text = GameValues.messages
