extends CanvasLayer

signal message_sent(message)

func _on_line_edit_text_submitted(new_text):
	message_sent.emit(new_text)
	$LineEdit.text = ""
	$LineEdit.focused = false
