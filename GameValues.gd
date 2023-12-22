extends Node

var players = {}
var typing = false
var messages = ""

signal message_sent

@rpc("any_peer", "call_local", "reliable")
func send_message(message = "MESSAGE_ERROR", username = "USERNAME_ERROR"):
	messages += username + ": " + message + "\n"
	message_sent.emit()
