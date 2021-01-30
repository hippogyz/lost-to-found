extends Node2D

signal restart()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$VC/CC3/HBoxContainer/Score.text = String(int(score))
	if Input.is_action_pressed("jump_order"):
		emit_signal("restart")
	pass



