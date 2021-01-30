extends Control

# Load the music player node
onready var _player = $AudioStreamPlayer

# Calling this function will load the given track, and play it
func play(track_url : String):
	var track = load(track_url)
	_player.stream = track
	_player.play()
func _ready():
	pass
	# play("res://sound/Chopin_-_Grande_valse_brillante_in_E_flat_major,_Op._18.ogg")
# Calling this function will stop the music
func stop():
	_player.stop()
