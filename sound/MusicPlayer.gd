extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

# Calling this function will load the given track, and play it
func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	_player.play()
func _ready():
	play("res://sound/improbable-by-kevin-macleod-from-filmmusic-io.ogg")
# Calling this function will stop the music
func stop():
	_player.stop()
